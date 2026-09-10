# PasswordAdmin (Enterprise Credential Vault & Smart Password Generator) <sup>v2.1.0</sup>

---

**Cơ sở dữ liệu quản lý tài khoản & công cụ tạo mật khẩu bảo mật cao (Zero-Knowledge & CSPRNG).**  
**Tạo và quản lý thông tin đăng nhập với quy trình chuẩn mực — cục bộ hoàn toàn, không cloud, không gửi dữ liệu ra ngoài thiết bị.**

**Local-First & Zero-Knowledge by Design**: Khác với các trình quản lý mật khẩu truyền thống lưu trữ dữ liệu trên đám mây của bên thứ ba, **PasswordAdmin** hoạt động hoàn toàn cục bộ trên máy của bạn. Khóa bí mật không bao giờ rời khỏi thiết bị. Mọi thao tác suy khóa, mã hóa và giải mã đều được thực hiện trực tiếp tại chỗ — **không cloud, không gửi dữ liệu ra ngoài**. Bản Web UI chính (`PasswordAdmin WebUI/`) dùng thêm một **loopback server cục bộ** (`crypto_bridge_server.exe` tại `http://127.0.0.1:8765`) chỉ để đọc/ghi vault và sinh mật khẩu qua `crypto_engine.exe`; toàn bộ lưu lượng không rời khỏi `127.0.0.1`.

---

[![GitHub Repo](https://img.shields.io/badge/GitHub-nguyenhungtran18%2FPasswordAdmin-181717?style=flat-square&logo=github)](https://github.com/nguyenhungtran18/PasswordAdmin)
[![Core Language](https://img.shields.io/badge/Core_Engine-TokenVector-blueviolet?style=flat-square&logo=codeforces)](https://github.com/nguyenhungtran18/TokenVector)
[![Architecture](https://img.shields.io/badge/Architecture-Native_AOT_+_Web_UI-0284c7?style=flat-square)](https://github.com/nguyenhungtran18/PasswordAdmin)
[![Encryption](https://img.shields.io/badge/Security-AES--256--GCM_PBKDF2--600k-059669?style=flat-square)](https://github.com/nguyenhungtran18/PasswordAdmin)
[![Interface](https://img.shields.io/badge/Theme-Modern_Light_Mode-0f172a?style=flat-square)](https://github.com/nguyenhungtran18/PasswordAdmin)
[![License: MIT](https://img.shields.io/badge/License-MIT-amber?style=flat-square)](https://github.com/nguyenhungtran18/PasswordAdmin/blob/main/LICENSE)

---

## ⚠️ Lưu Ý Quan Trọng (Security Disclaimer)

**Bằng việc sử dụng phần mềm này, bạn hiểu và đồng ý với các nguyên tắc bảo mật Zero-Knowledge sau:**

* **Không có cơ chế "Quên Mật Khẩu":** Mật khẩu chính (**Master Password**) là chìa khóa duy nhất để suy ra khóa mã hóa và giải mã dữ liệu của bạn. Không ai — kể cả tác giả hay bất kỳ hệ thống nào — có thể khôi phục lại dữ liệu nếu bạn làm mất Master Password (kể cả sau khi đổi mật khẩu mới).
* **Tự Chủ Quyền Riêng Tư (Full Sovereignty):** Toàn bộ cơ sở dữ liệu Web UI được lưu trực tiếp trên máy cục bộ của bạn (`PasswordAdmin WebUI/PasswordVault.vault.json`, định dạng JSON mã hóa AES-256-GCM) hoặc tệp sao lưu JSON do bạn quản lý. Tệp `vault.tkvdb` là database của bản CLI TokenVector legacy, không phải DB mặc định của Web UI.
* **Phần mềm được cung cấp nguyên trạng ("AS IS"):** Vui lòng lưu trữ Master Password và tạo bản sao lưu dữ liệu thường xuyên.

---

## 🚀 Trụ Cột Cốt Lõi: TokenVector Core Engine

Hạt nhân xử lý mật mã học và hệ thống chỉ mục tìm kiếm tốc độ cao của **PasswordAdmin** được xây dựng bằng ngôn ngữ lập trình **[TokenVector](https://github.com/nguyenhungtran18/TokenVector)**:

* ⚡ **Tìm Kiếm Theo App/User:** Module TokenVector native (`token_vector_engine.tkv`) thử nghiệm chỉ mục đảo ngược cho bản CLI. **Web UI hiện tại tìm kiếm bằng lọc tuyến tính $O(N)$** (`Array.filter` theo Tên App + Tên User), đủ nhanh ở quy mô vài nghìn bản ghi.
* 🛡️ **An Toàn Bộ Nhớ (Memory Safety):** Mục tiêu thiết kế của TokenVector là giảm nguy cơ tràn bộ đệm (Buffer Overflow) và lỗi quản lý bộ nhớ thường gặp trong code native.
* 📦 **Biên Dịch AOT Native Độc Lập:** Mã nguồn `.tkv` được biên dịch AOT thành binary PE native (`PasswordAdmin.exe` ~30 KB), khởi động ngay mà không cần cài đặt môi trường cồng kềnh.

🔗 **Tìm hiểu thêm về ngôn ngữ TokenVector:** [https://github.com/nguyenhungtran18/TokenVector](https://github.com/nguyenhungtran18/TokenVector)

---

## 🎯 Nguyên Tắc Vận Hành (Core Principles)

- **Quy Trình Khai Báo Nghiêm Ngặt (Mandatory Pre-Declaration):** Người dùng bắt buộc phải khai báo (1) Tên Ứng dụng/Dịch vụ và (2) Tên Người dùng/Email trước khi tiến hành tạo hoặc lưu mật khẩu.
- **Bảo Mật Bộ Đệm Tự Hủy (Auto-Purge Clipboard 10s):** Mật khẩu sao chép vào bộ nhớ tạm (Clipboard) sẽ tự động bị xóa sạch sau 10 giây để chống lại các mã độc theo dõi clipboard (Clipboard Hijackers).
- **CSPRNG Lai (Bridge + Fallback):** Web UI ưu tiên gọi loopback server `GET http://127.0.0.1:8765/generate?length=N` (server gọi `crypto_engine.exe --generate`, chỉ nhận độ dài 8–64); khi server không chạy hoặc tắt ký tự đặc biệt/chữ số, fallback sang `window.crypto.getRandomValues` của trình duyệt.
- **Tìm Kiếm Kép Đa Trường (Dual-Field Realtime Search):** Tra cứu độc lập hoặc kết hợp đồng thời theo Tên App và Tên User thời gian thực (lọc tuyến tính, phân biệt không dấu theo đúng chuỗi nhập).
- **Đổi Master Password (Re-encrypt Vault):** Đổi mật khẩu đăng nhập/mở két ngay trong Web UI (nút chìa khóa trên header): xác thực mật khẩu cũ → sinh salt 16 bytes mới → suy khóa mới bằng PBKDF2 → mã hóa lại toàn bộ vault (AES-256-GCM) và ghi đè DB mặc định.
- **Giao Diện Kép Linh Hoạt (Dual-Interface):** Vừa hỗ trợ giao diện Web UI hiện đại (nền trắng chữ đen, tương phản cao), vừa hỗ trợ Native CLI cho môi trường dòng lệnh/terminal. Lưu ý: bản Web UI chính **yêu cầu chạy loopback server cục bộ** qua `Open_PasswordAdmin_Web.bat`, không phải "zero-server" hoàn toàn.

---

## 💎 Những Điều Bạn Có Thể Làm (What You Can Do)

1. **Tạo Mật Khẩu Chuẩn Quy Trình:** Nhập thông tin App & User trước, sau đó bấm tạo mật khẩu ngẫu nhiên CSPRNG với 1 click.
2. **Tùy Biến Độ Dài & Độ Phức Tạp:** Thanh trượt độ dài 10 đến 64 ký tự (server `crypto_engine.exe` chỉ nhận 8–64), bật/tắt ký tự đặc biệt và chữ số. *Hiện tại chưa có tùy chọn loại bỏ ký tự dễ nhầm (`l`, `1`, `I`, `0`, `O`).*
3. **Đo Lường Entropy Thời Gian Thực:** Thước đo Entropy toán học ($E = L \times \log_2(N)$) và ước tính thời gian Brute-force bẻ khóa. Xếp hạng còn xét thêm độ dài tối thiểu (8/12/16 ký tự).
4. **Quản Lý Cơ Sở Dữ Liệu Dạng Bảng (CRUD):** Xem danh sách, ẩn/hiện mật khẩu dạng `••••••••`, chỉnh sửa và xóa bản ghi với giao diện DataTable trực quan.
5. **Sao Lưu & Di Chuyển Dữ Liệu (Backup & Restore):** Xuất toàn bộ vault **đang mã hóa AES-256-GCM** ra JSON (`PasswordVault_Backup_YYYY-MM-DD.json`) hoặc nạp tệp sao lưu (yêu cầu đúng Master Password/salt tương ứng) chỉ trong 1 thao tác.
6. **Bảo Vệ Bằng Két Sắt Master Vault:** Khóa toàn bộ ứng dụng khi rời máy tính, giải mã lại tức thì bằng Master Password.
7. **Đổi Mật Khẩu Đăng Nhập:** Đổi Master Password ngay trong Web UI mà không mất dữ liệu — vault được mã hóa lại với salt mới và lưu đè lên DB mặc định.

---

## 🔬 Nền Tảng Kỹ Thuật (Technical Foundation)

### So sánh & Thông số Kỹ thuật:

| Thành phần | Đặc tả kỹ thuật | Mục đích & Lợi ích |
|:---|:---|:---|
| **Core Language** | **[TokenVector](https://github.com/nguyenhungtran18/TokenVector)** (`.tkv`) | Module native cho CLI/engine mật mã & tìm kiếm |
| **Search Engine (Web UI)** | Lọc tuyến tính theo App + User ($O(N)$) | Đủ nhanh ở quy mô vài nghìn bản ghi, tìm kiếm thời gian thực |
| **CSPRNG Engine** | `crypto_bridge_server.exe` + `crypto_engine.exe --generate` (8–64 ký tự), fallback `crypto.getRandomValues` | Ưu tiên engine native, tự fallback khi server tắt |
| **Vault Encryption** | PBKDF2-HMAC-SHA256 600.000 iterations → AES-256-GCM (salt 16 bytes, IV 12 bytes, JSON `{version, algorithm, kdf, salt, iv, ciphertext}`) | Zero-Knowledge: server/file chỉ thấy bản mã, không bao giờ thấy Master Password |
| **Web Presentation** | HTML5 + Tailwind CSS + Lucide Icons | Nền trắng chữ đen (Light Mode), tương phản cao; bản Web UI chính cần loopback server `127.0.0.1:8765` |
| **Auto-Purge Timer** | 10.000 ms (10 giây) | Xóa sạch clipboard tự động sau khi copy |

### Bảng Ký Tự Tiêu Chuẩn (Google & Enterprise Compatible):
```text
abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_=+[]{}|;:,.<>?
```

### Tiêu Chuẩn Đánh Giá Mật Khẩu (Password Strength Scale — khớp code Web UI):
- **Cực mạnh (rating 4, badge "Cực Mạnh (Safe)"):** $\ge 85\text{ bits}$ Entropy **và** dài $\ge 16$ ký tự.
- **Tốt (rating 3):** $65 - 84\text{ bits}$ Entropy **hoặc** dài 12–15 ký tự.
- **Trung bình (rating 2):** $40 - 64\text{ bits}$ Entropy **hoặc** dài 8–11 ký tự.
- **Yếu (rating 1):** $< 40\text{ bits}$ Entropy **hoặc** dài $< 8$ ký tự.

---

## 📥 Hướng Dẫn Tải & Cài Đặt (Download & Setup)

### 1. Tải Gói Cài Đặt Sẵn (Pre-built Release)
Tải phiên bản đóng gói sẵn chính thức từ GitHub Release:

📦 **Link Tải Trực Tiếp (bản cũ):** 👉 **[PasswordAdmin.zip (v1.0.0)](https://github.com/nguyenhungtran18/PasswordAdmin/releases/download/v1.0.0/PasswordAdmin.zip)** — README này mô tả mã nguồn hiện tại (v2.1.0); nếu tải release cũ, một số tính năng (Đổi Master Password, bridge server 8765) có thể chưa có.

---

### 2. Hướng Dẫn Giải Nén
1. Sau khi tải tệp `PasswordAdmin.zip`, nhấp chuột phải vào tệp và chọn **Extract All...** (hoặc sử dụng phần mềm 7-Zip / WinRAR chọn **Extract to PasswordAdmin**).
2. Chọn thư mục lưu trữ thuận tiện trên máy tính (ví dụ: `D:\PasswordAdmin` hoặc `C:\Tools\PasswordAdmin`).
3. Mở thư mục vừa giải nén, bạn sẽ thấy các tệp: `PasswordAdmin WebUI/index.html`, `Open_PasswordAdmin_Web.bat`, `crypto_bridge_server.exe`, `PasswordAdmin.exe`, `README.md`, v.v. (bản root `index.html` là biến thể dùng File System Access API, không phải entry-point chính).

---

### 3. Hướng Dẫn Vào Phần Mềm Lần Đầu Tiên (First-Time Setup)

1. **Khởi chạy ứng dụng (bắt buộc dùng file .bat):**
   - Nhấp đúp chuột vào tệp **`Open_PasswordAdmin_Web.bat`**. File này làm 2 việc: khởi động `crypto_bridge_server.exe --server 8765` rồi mở `PasswordAdmin WebUI/index.html`.
   - ⚠️ Không nhấp đúp trực tiếp `index.html` qua `file://` vì Web UI cần loopback server `127.0.0.1:8765` để đọc/ghi vault và sinh mật khẩu — mở chay sẽ báo "Không thể đọc DB" / "Crypto server chưa chạy". Giữ cửa sổ server luôn mở. Dùng Google Chrome hoặc Microsoft Edge mới nhất.

2. **Đăng nhập lần đầu — mật khẩu mặc định là `123456`:**
   - Tại màn hình hộp thoại **Két Sắt Mật Khẩu (Vault)**, bạn nhập `123456` vào ô *Master Password*.
   - Bấm nút **"Mở Khóa Cơ Sở Dữ Liệu"** để vào giao diện quản trị chính (DB đi kèm đã có sẵn 3 bản ghi demo).
   - 💡 *Lưu ý quan trọng:* Vì hệ thống tuân thủ mô hình bảo mật Zero-Knowledge, Master Password được dùng để **suy khóa AES-256-GCM qua PBKDF2-HMAC-SHA256 600.000 iterations với salt 16 bytes** (không lưu mật khẩu ở bất kỳ đâu). Hãy **đổi ngay mật khẩu mặc định** theo bước 5 bên dưới!
   - Trường hợp DB trống (xóa file vault / chạy bản root): mật khẩu bạn nhập ở lần mở đầu tiên sẽ trở thành Master Password của vault mới.

3. **Tạo tài khoản & mật khẩu đầu tiên:**
   - Bấm nút **"Tạo Key Mới"** (màu xanh ở góc phải trên).
   - **Bước 1 (Khai báo bắt buộc):** Nhập *Tên Ứng Dụng / Dịch Vụ* (ví dụ: `Google`, `GitHub`, `Binance`...) và *Tên Người Dùng / Email* (ví dụ: `security_admin@gmail.com`).
   - **Bước 2 (Tạo Key):** Bấm nút **"Tạo Ngẫu Nhiên (CSPRNG)"** để phần mềm tự động tính toán và sinh mật khẩu 20 ký tự đạt mức *Cực Mạnh (Unbreakable)*, hoặc tự nhập mật khẩu riêng của bạn.
   - Bấm **"Lưu Vào Database"** để hoàn tất bản ghi đầu tiên!

4. **Sao chép an toàn với Auto-Purge Clipboard:**
   - Tại dòng tài khoản vừa lưu, bấm biểu tượng **Copy**.
   - Mật khẩu sẽ được sao chép vào bộ nhớ đệm và **tự động bị xóa vĩnh viễn khỏi Clipboard sau 10 giây** để bảo vệ an toàn.

5. **Đổi Master Password ngay trong app (bắt buộc sau lần đăng nhập đầu):**
   - Sau khi đã mở két bằng `123456`, bấm biểu tượng **chìa khóa 🔑** trên thanh header (cạnh nút Khóa) để mở hộp thoại **"Đổi Master Password"**.
   - Nhập *mật khẩu hiện tại* (`123456`) → nhập *mật khẩu mới* (tối thiểu 8 ký tự, khuyến nghị 12–16, có thước đo mạnh/yếu) → *xác nhận lại* → bấm **"Đổi Mật Khẩu"**.
   - App xác thực mật khẩu cũ bằng cách thử giải mã vault, sau đó sinh salt 16 bytes mới, suy khóa mới bằng PBKDF2 và **mã hóa lại toàn bộ vault (AES-256-GCM), ghi đè DB mặc định**. Từ lần sau dùng mật khẩu mới để đăng nhập — nếu quên là mất dữ liệu.

---

## 💻 Hướng Dẫn Vận Hành Bằng Dòng Lệnh CLI (TokenVector Native)
Dành cho nhà phát triển muốn chạy CLI hoặc biên dịch lại bằng công cụ phát triển **[TokenVector SDK](https://github.com/nguyenhungtran18/TokenVector)**:

```bash
# Biên dịch AOT từ mã nguồn TokenVector ra tệp nhị phân native:
tkvc.exe PasswordAdmin.tkv -o PasswordAdmin.exe

# Chạy ứng dụng console:
.\PasswordAdmin.exe
```

---

## 📁 Cấu Trúc Dự Án (Project Structure)

```text
PasswordAdmin/
├── PasswordAdmin WebUI/         # Entry-point chính: index.html + PasswordVault.vault.json + Open_PasswordAdmin_Web.bat
│   ├── index.html               # Web UI chính (đọc/ghi vault qua loopback server 127.0.0.1:8765)
│   ├── PasswordVault.vault.json # DB mặc định của Web UI (JSON mã hóa AES-256-GCM)
│   ├── crypto_bridge_server.exe # Loopback server cục bộ (vault + sinh mật khẩu)
│   └── Open_PasswordAdmin_Web.bat # 1-click: chạy server rồi mở Web UI (lưu ý: fix dấu `"` thừa ở cuối dòng start)
├── index.html                   # Biến thể Web UI dùng File System Access API (showSaveFilePicker, Chrome/Edge)
├── Open_PasswordAdmin_Web.bat   # 1-click mở bản Web UI chính + server (hiện đã đổi target sang PasswordAdmin WebUI/)
├── crypto_bridge.py / .tkv / .exe         # Bridge HTTP GET /generate?length= (8–64) → gọi crypto_engine.exe
├── crypto_engine.tkv / .exe / crypto_engine_new.exe # Engine sinh mật khẩu native
├── PasswordAdmin.tkv / .exe (~30 KB)       # Điều phối chính + binary CLI
├── token_vector_engine.tkv      # Module chỉ mục/tìm kiếm phía native (Web UI không dùng, Web UI lọc O(N))
├── vault_repository.tkv         # Module lưu trữ két sắt phía native
├── models.tkv / main.tkv / ui_desktop.tkv  # Thực thể dữ liệu & engine CLI
├── vault.tkvdb                  # DB của bản CLI legacy (plaintext `App|user|pass`), KHÔNG phải DB của Web UI
├── LICENSE                      # Giấy phép MIT License
└── README.md                    # Tài liệu hướng dẫn sử dụng & đặc tả kỹ thuật (v2.1.0)
```

---

## 🛡️ Yêu Cầu Bảo Mật Khuyến Nghị (Security Best Practices)

### Quy Tắc Đặt Master Password:
- App bắt buộc tối thiểu 8 ký tự khi đổi/mở két; **khuyến nghị 12 đến 16 ký tự trở lên**.
- Kết hợp chữ hoa, chữ thường, số và ký tự đặc biệt.
- Tuyệt đối không chia sẻ hoặc lưu Master Password ở dạng văn bản thuần (plaintext) trên máy tính. Sao lưu file `PasswordVault.vault.json` thường xuyên — mất mật khẩu là mất dữ liệu.

```text
✅ Ví dụ mật khẩu an toàn:
   • "Tr0ngV3ct0r#Vault@2026!Sec"
   • "K3tSat#BaoMat$DoiThuong&99"

❌ Các mật khẩu cần tránh:
   • "12345678", "password", "admin"
   • Tên cá nhân hoặc ngày sinh nhật dễ đoán
```

---

## 📜 Lịch Sử Phiên Bản (Version History)

| Phiên bản | Công nghệ Core | Trạng thái | Điểm cải tiến chính |
|:---|:---|:---|:---|
| **v1.0.0** | TokenVector CLI | 📦 Legacy | Bản dựng ban đầu chạy trên console terminal với AOT compilation. |
| **v2.0.0** | **TokenVector + Web UI** | 📦 Trước đây | Thêm Web UI nền trắng chữ đen với đầy đủ UI Components, chuẩn hóa luồng nhập App/User trước khi tạo Key, thanh tìm kiếm kép, đếm ngược 10s Auto-Purge Clipboard. |
| **v2.1.0** | **TokenVector + Web UI + Bridge** | 🚀 **Hiện tại (Current)** | Thêm **Đổi Master Password** (mã hóa lại vault với salt mới), loopback server `127.0.0.1:8765` cho đọc/ghi vault + sinh mật khẩu native, fix copy mật khẩu chứa ký tự đặc biệt, làm rõ đặc tả mã hóa AES-256-GCM/PBKDF2-600k. |

---

## 📄 Giấy Phép (License)

Dự án được phân phối dưới giấy phép **[MIT License](https://github.com/nguyenhungtran18/PasswordAdmin/blob/main/LICENSE)**.

Bản quyền (©) 2026 thuộc về **nguyenhungtran18**.

---

## 🤝 Đóng Góp & Hỗ Trợ (Support & Ecosystem)

* **Báo cáo lỗi & Góp ý tính năng:** [GitHub Issues](https://github.com/nguyenhungtran18/PasswordAdmin/issues)
* **Hệ sinh thái ngôn ngữ TokenVector:** [https://github.com/nguyenhungtran18/TokenVector](https://github.com/nguyenhungtran18/TokenVector)
* **Tác giả:** [nguyenhungtran18](https://github.com/nguyenhungtran18)
