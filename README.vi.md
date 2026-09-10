# PasswordAdmin (Enterprise Credential Vault & Smart Password Generator) <sup>v2.2.0</sup>

---

**Cơ sở dữ liệu quản lý tài khoản & công cụ tạo mật khẩu bảo mật cao (Mã hóa cục bộ & CSPRNG).**  
**Tạo và quản lý thông tin đăng nhập với quy trình chuẩn mực — cục bộ hoàn toàn, không cloud, không gửi dữ liệu ra ngoài thiết bị.**

**Local-First by Design (mã hóa phía máy khách)**: Khác với các trình quản lý mật khẩu truyền thống lưu trữ dữ liệu trên đám mây của bên thứ ba, **PasswordAdmin** hoạt động hoàn toàn cục bộ trên máy của bạn. Khóa bí mật không bao giờ rời khỏi thiết bị. Mọi thao tác suy khóa, bọc/mở khóa và giải mã vault đều diễn ra trong trình duyệt của bạn — **không cloud, không tài khoản, không gửi dữ liệu ra ngoài**. Bản Web UI chính (`PasswordAdmin WebUI/`) dùng thêm một **loopback server cục bộ** (`crypto_bridge_server.exe` tại `http://127.0.0.1:8765`) chỉ để đọc/ghi file vault (dạng bản mã) và sinh mật khẩu ngẫu nhiên nội bộ; toàn bộ lưu lượng không rời khỏi `127.0.0.1`.

*Ghi chú thuật ngữ: app **không** dùng zero-knowledge proof (giao thức chứng minh không tiết lộ tri thức). Bảo mật dựa trên mã hóa xác thực chuẩn **AES-256-GCM + PBKDF2-HMAC-SHA256 600.000 iterations**. Mọi chỗ trong tài liệu/bản cũ ghi "Zero-Knowledge" đều nên hiểu đúng là "mã hóa cục bộ, không server".*

---

[![GitHub Repo](https://img.shields.io/badge/GitHub-nguyenhungtran18%2FPasswordAdmin-181717?style=flat-square&logo=github)](https://github.com/nguyenhungtran18/PasswordAdmin)
[![Architecture](https://img.shields.io/badge/Architecture-Web_UI-0284c7?style=flat-square)](https://github.com/nguyenhungtran18/PasswordAdmin)
[![Encryption](https://img.shields.io/badge/Security-AES--256--GCM_PBKDF2--600k-059669?style=flat-square)](https://github.com/nguyenhungtran18/PasswordAdmin)
[![Interface](https://img.shields.io/badge/Theme-Modern_Light_Mode-0f172a?style=flat-square)](https://github.com/nguyenhungtran18/PasswordAdmin)
[![License: MIT](https://img.shields.io/badge/License-MIT-amber?style=flat-square)](https://github.com/nguyenhungtran18/PasswordAdmin/blob/main/LICENSE)

---

## ⚠️ Lưu Ý Quan Trọng (Security Disclaimer)

**Bằng việc sử dụng phần mềm này, bạn hiểu và đồng ý với các nguyên tắc bảo mật cốt lõi sau:**

* **Khôi phục bằng Recovery Key (không còn "mất là hết"):** Két vault v2 dùng khóa mã hóa dữ liệu (DEK) được bọc 2 lớp độc lập — bằng Master Password **và** bằng Recovery Key 24 từ. Quên mật khẩu thì dùng Recovery Key để đặt lại (xem mục 6 bên dưới). **Ai giữ Recovery Key thì người đó mở được két** — đây là định nghĩa "chủ két" trong mô hình local-only (không tài khoản, không server xác thực). Mất **cả hai** (mật khẩu + Recovery Key) thì không ai — kể cả tác giả — cứu được dữ liệu.
* **Tự Chủ Quyền Riêng Tư (Full Sovereignty):** Toàn bộ cơ sở dữ liệu được lưu trực tiếp trên máy cục bộ của bạn (`PasswordAdmin WebUI/PasswordVault.vault.json`, định dạng JSON mã hóa AES-256-GCM) hoặc tệp sao lưu JSON do bạn quản lý.
* **Phần mềm được cung cấp nguyên trạng ("AS IS"):** Vui lòng lưu trữ Master Password và tạo bản sao lưu dữ liệu thường xuyên.

---

## 🎯 Nguyên Tắc Vận Hành (Core Principles)

- **Quy Trình Khai Báo Nghiêm Ngặt (Mandatory Pre-Declaration):** Người dùng bắt buộc phải khai báo (1) Tên Ứng dụng/Dịch vụ và (2) Tên Người dùng/Email trước khi tiến hành tạo hoặc lưu mật khẩu.
- **Bảo Mật Bộ Đệm Tự Hủy (Auto-Purge Clipboard 10s):** Mật khẩu sao chép vào bộ nhớ tạm (Clipboard) sẽ tự động bị xóa sạch sau 10 giây để chống lại các mã độc theo dõi clipboard (Clipboard Hijackers).
- **CSPRNG Lai (Bridge + Fallback):** Web UI ưu tiên gọi loopback server `GET http://127.0.0.1:8765/generate?length=N` (server sinh mật khẩu nội bộ, **luôn trả cố định 20 ký tự** bất kể `length` yêu cầu); chỉ gọi bridge khi bật cả ký tự đặc biệt + chữ số, còn lại fallback sang `window.crypto.getRandomValues` của trình duyệt.
- **Tìm Kiếm Kép Đa Trường (Dual-Field Realtime Search):** Tra cứu độc lập hoặc kết hợp đồng thời theo Tên App và Tên User thời gian thực (lọc tuyến tính, phân biệt không dấu theo đúng chuỗi nhập).
- **Đổi Master Password (Re-wrap DEK):** Đổi mật khẩu đăng nhập/mở két ngay trong Web UI (nút chìa khóa trên header): xác thực mật khẩu cũ bằng cách mở thử DEK → bọc lại DEK bằng mật khẩu mới (salt mới) → ghi đè DB. Recovery Key giữ nguyên hiệu lực.
- **Recovery Key 24 từ (BIP39):** Chìa khóa dự phòng khi quên mật khẩu — sinh ngẫu nhiên, hiện đúng 1 lần, xác nhận bằng cách nhập lại 3 từ. Ghi ra giấy, cất offline.
- **Rate-limit + Nhật ký bảo mật:** Sai mật khẩu/key quá 5 lần thì tạm khóa 60 giây; mọi sự kiện (mở két, đổi pass, khôi phục, khóa tạm) ghi vào nhật ký cục bộ, xem lại trong modal "Khôi phục & Bảo mật".
- **Web UI Duy Nhất:** Chỉ hỗ trợ giao diện Web UI hiện đại (nền trắng chữ đen, tương phản cao, dùng ngay trên trình duyệt). Lưu ý: bản Web UI chính **yêu cầu chạy loopback server cục bộ** qua `Open_PasswordAdmin_Web.bat`, không phải "zero-server" hoàn toàn.

---

## 💎 Những Điều Bạn Có Thể Làm (What You Can Do)

1. **Tạo Mật Khẩu Chuẩn Quy Trình:** Nhập thông tin App & User trước, sau đó bấm tạo mật khẩu ngẫu nhiên CSPRNG với 1 click.
2. **Tùy Biến Độ Dài & Độ Phức Tạp:** Thanh trượt độ dài 10 đến 64 ký tự (chỉ có tác dụng khi tắt bớt 1 ô tùy chọn hoặc server tắt — đường bridge mặc định luôn trả cố định 20 ký tự), bật/tắt ký tự đặc biệt và chữ số. *Hiện tại chưa có tùy chọn loại bỏ ký tự dễ nhầm (`l`, `1`, `I`, `0`, `O`).*
3. **Đo Lường Entropy Thời Gian Thực:** Thước đo Entropy toán học ($E = L \times \log_2(N)$) và ước tính thời gian Brute-force bẻ khóa. Xếp hạng còn xét thêm độ dài tối thiểu (8/12/16 ký tự).
4. **Quản Lý Cơ Sở Dữ Liệu Dạng Bảng (CRUD):** Xem danh sách, ẩn/hiện mật khẩu dạng `••••••••`, chỉnh sửa và xóa bản ghi với giao diện DataTable trực quan.
5. **Sao Lưu & Di Chuyển Dữ Liệu (Backup & Restore):** Xuất toàn bộ vault **đang mã hóa AES-256-GCM** ra JSON (`PasswordVault_Backup_YYYY-MM-DD.json`) hoặc nạp tệp sao lưu (yêu cầu đúng Master Password/salt tương ứng) chỉ trong 1 thao tác.
6. **Bảo Vệ Bằng Két Sắt Master Vault:** Khóa toàn bộ ứng dụng khi rời máy tính, giải mã lại tức thì bằng Master Password.
7. **Đổi Mật Khẩu Đăng Nhập:** Đổi Master Password ngay trong Web UI mà không mất dữ liệu — DEK được bọc lại với salt mới và lưu đè lên DB mặc định (Recovery Key giữ nguyên).
8. **Tạo Recovery Key & Tự Khôi Phục Khi Quên Mật Khẩu:** Tạo key 24 từ một lần (file `PasswordAdmin-Recovery-Key.txt` tự tải về khi kích hoạt, xoay key thì file mới cùng tên tự tải về đè lên), quên pass thì gõ tay hoặc **nạp file Emergency Kit (.txt)** ở màn hình khóa để tự đặt lại — không mất dữ liệu, app không bao giờ tự xóa két.
9. **Nút Help Trong Dashboard:** Bấm dấu `?` trên header bất cứ lúc nào để mở popup hướng dẫn sử dụng tóm tắt (đăng nhập, tạo key, copy, recovery, sao lưu, 3 điều không được quên).

---

## 🔬 Nền Tảng Kỹ Thuật (Technical Foundation)

### So sánh & Thông số Kỹ thuật:

| Thành phần | Đặc tả kỹ thuật | Mục đích & Lợi ích |
|:---|:---|:---|
| **Search Engine** | Lọc tuyến tính theo App + User ($O(N)$) | Đủ nhanh ở quy mô vài nghìn bản ghi, tìm kiếm thời gian thực |
| **CSPRNG Engine** | loopback server `crypto_bridge_server.exe` (port 8765, luôn trả 20 ký tự; chỉ gọi khi bật cả ký tự đặc biệt + chữ số), fallback `crypto.getRandomValues` | Ưu tiên server nội bộ, tự fallback khi server tắt hoặc tắt bớt tùy chọn |
| **Vault Encryption** | Vault **v2 (envelope)**: DEK-256 ngẫu nhiên mã hóa records (AES-256-GCM); DEK bọc 2 lớp độc lập bằng KEK = PBKDF2-HMAC-SHA256 600.000 iterations từ (a) Master Password, (b) Recovery Key 24 từ. Vault v1 legacy tự migrate khi mở két. | Mã hóa phía máy khách: Master Password và Recovery Key không bao giờ rời khỏi trình duyệt; file vault chỉ chứa bản mã. Ngoại lệ duy nhất: mật khẩu vừa sinh bằng bridge đi qua loopback HTTP (`127.0.0.1:8765`) dưới dạng plaintext — chỉ ở trong máy bạn, nhưng tiến trình local khác về lý thuyết có thể đọc được |
| **Recovery Key** | 24 từ BIP39 English (2048 từ, ~264-bit entropy) + PBKDF2-600k; hiện 1 lần, xác nhận 3 từ, hỗ trợ tải Emergency Kit `.txt` | Quên pass vẫn tự khôi phục, không cần ai khác |
| **Chống đoán mò** | Sai quá 5 lần → khóa 60s (lưu localStorage) + nhật ký 100 sự kiện | Chống kẻ mượn máy đoán mò tại chỗ |
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

📦 **Link Tải Trực Tiếp (bản cũ):** 👉 **[PasswordAdmin.zip (v1.0.0)](https://github.com/nguyenhungtran18/PasswordAdmin/releases/download/v1.0.0/PasswordAdmin.zip)** — README này mô tả mã nguồn hiện tại (v2.2.0); nếu tải release cũ, một số tính năng (Recovery Key, Đổi Master Password, bridge server 8765) có thể chưa có.

---

### 2. Hướng Dẫn Giải Nén
1. Sau khi tải tệp `PasswordAdmin.zip`, nhấp chuột phải vào tệp và chọn **Extract All...** (hoặc sử dụng phần mềm 7-Zip / WinRAR chọn **Extract to PasswordAdmin**).
2. Chọn thư mục lưu trữ thuận tiện trên máy tính (ví dụ: `D:\PasswordAdmin` hoặc `C:\Tools\PasswordAdmin`).
3. Mở thư mục vừa giải nén, bạn sẽ thấy các tệp: `PasswordAdmin WebUI/index.html`, `Open_PasswordAdmin_Web.bat`, `crypto_bridge_server.exe`, `README.md`, v.v. (bản root `index.html` là biến thể dùng File System Access API, không phải entry-point chính).

---

### 3. Hướng Dẫn Vào Phần Mềm Lần Đầu Tiên (First-Time Setup)

1. **Khởi chạy ứng dụng (bắt buộc dùng file .bat):**
   - Nhấp đúp chuột vào tệp **`Open_PasswordAdmin_Web.bat`**. File này làm 2 việc: khởi động `crypto_bridge_server.exe --server 8765` rồi mở `PasswordAdmin WebUI/index.html`.
   - ⚠️ Không nhấp đúp trực tiếp `index.html` qua `file://` vì Web UI cần loopback server `127.0.0.1:8765` để đọc/ghi vault và sinh mật khẩu — mở chay sẽ báo "Không thể đọc DB" / "Crypto server chưa chạy". Giữ cửa sổ server luôn mở. Dùng Google Chrome hoặc Microsoft Edge mới nhất.

2. **Đăng nhập lần đầu — mật khẩu mặc định là `123456`:**
   - Tại màn hình hộp thoại **Két Sắt Mật Khẩu (Vault)**, bạn nhập `123456` vào ô *Master Password*.
   - Bấm nút **"Mở Khóa Cơ Sở Dữ Liệu"** để vào giao diện quản trị chính (DB đi kèm đã có sẵn 3 bản ghi demo; vault v1 legacy tự nâng lên v2 khi mở).
   - 💡 *Lưu ý quan trọng:* Vì hệ thống mã hóa phía máy khách (client-side), Master Password được dùng để **suy khóa bọc DEK qua PBKDF2-HMAC-SHA256 600.000 iterations với salt 16 bytes** (không lưu mật khẩu ở bất kỳ đâu). Hãy **đổi ngay mật khẩu mặc định** (bước 5) rồi **tạo Recovery Key** (bước 6) — banner vàng trong app sẽ nhắc cho đến khi xong! Lạc đường thì bấm nút `?` trên header để mở popup hướng dẫn nhanh.
   - Trường hợp DB trống (xóa file vault / chạy bản root): mật khẩu bạn nhập ở lần mở đầu tiên sẽ trở thành Master Password của vault mới (sinh DEK mới, định dạng v2).

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
   - App xác thực mật khẩu cũ bằng cách mở thử DEK, sau đó bọc lại DEK bằng mật khẩu mới (salt 16 bytes mới) và **ghi đè DB mặc định**. Recovery Key (nếu đã tạo) giữ nguyên hiệu lực. Từ lần sau dùng mật khẩu mới để đăng nhập.

6. **Tạo Recovery Key + cách khôi phục khi quên mật khẩu:**
   - **Tạo key:** Bấm icon **phao cứu sinh 🛟** trên header → **"Tạo Recovery Key (24 từ)"** → key hiện **đúng 1 lần**: ghi ra giấy/cất offline, rồi nhập lại 3 từ được hỏi để kích hoạt. Bấm kích hoạt là file `PasswordAdmin-Recovery-Key.txt` **tự tải về** (khỏi cần bấm nút tải tay). Muốn đổi key thì **"Xoay Recovery Key"** — file `.txt` mới cùng tên tự tải về đè lên file cũ (nếu trình duyệt lưu thành file `(1)` riêng thì nhớ xóa file cũ tay), key cũ vô hiệu ngay.
   - **Quên mật khẩu (2 cách, không cần gõ tay):** Ở màn hình khóa bấm **"Quên mật khẩu? Khôi phục bằng Recovery Key"** → hoặc (a) nhập đủ 24 từ (chấp nhận phẩy/chấm phẩy/xuống dòng), hoặc (b) bấm **"Nạp file Emergency Kit (.txt)"** để app tự điền → bấm Xác minh → đặt Master Password mới → két mở lại, dữ liệu nguyên vẹn, Recovery Key giữ nguyên.
   - **Mất cả hai:** App **không có và không bao giờ có nút xóa két** — dữ liệu của bạn được giữ nguyên trong file vault, chỉ là tạm thời không ai mở được (kể cả tác giả). Hãy tìm lại tờ key/file Emergency Kit đã lưu; đó là lý do bước tạo key bắt xác nhận 3 từ.
   - **Ai là chủ két?** App không có tài khoản/server nên không "xác minh danh tính" kiểu CCCD/email được — **ai giữ Recovery Key (hoặc nhớ mật khẩu) thì người đó là chủ**. Vì vậy: cất key như cất chìa khóa nhà. Sai quá 5 lần bị khóa 60s; mọi sự kiện ghi vào **Nhật ký bảo mật** (xem trong modal 🛟) để phát hiện truy cập lạ.

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
├── crypto_bridge.py / .exe                # Bridge HTTP: đọc/ghi vault + sinh mật khẩu (luôn trả 20 ký tự)
├── LICENSE                      # Giấy phép MIT License
└── README.md                    # Tài liệu hướng dẫn sử dụng & đặc tả kỹ thuật (v2.2.0)
```

---

## 🛡️ Yêu Cầu Bảo Mật Khuyến Nghị (Security Best Practices)

### Quy Tắc Đặt Master Password:
- App bắt buộc tối thiểu 8 ký tự khi đổi/mở két; **khuyến nghị 12 đến 16 ký tự trở lên**.
- Kết hợp chữ hoa, chữ thường, số và ký tự đặc biệt.
- Tuyệt đối không chia sẻ hoặc lưu Master Password ở dạng văn bản thuần (plaintext) trên máy tính. Sao lưu file `PasswordVault.vault.json` thường xuyên.
- **Recovery Key: in ra giấy, cất tách khỏi máy tính** (két sắt/tủ hồ sơ). Không chụp màn hình, không lưu cloud/email/chat. Mất cả mật khẩu lẫn Recovery Key là mất dữ liệu — không có ngoại lệ.

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

| Phiên bản | Nền tảng | Trạng thái | Điểm cải tiến chính |
|:---|:---|:---|:---|
| **v2.0.0** | **Web UI** | 📦 Trước đây | Web UI nền trắng chữ đen với đầy đủ UI Components, chuẩn hóa luồng nhập App/User trước khi tạo Key, thanh tìm kiếm kép, đếm ngược 10s Auto-Purge Clipboard. |
| **v2.1.0** | **Web UI + Bridge** | 📦 Trước đây | Thêm **Đổi Master Password**, loopback server `127.0.0.1:8765` cho đọc/ghi vault + sinh mật khẩu native, fix copy mật khẩu chứa ký tự đặc biệt, làm rõ đặc tả mã hóa AES-256-GCM/PBKDF2-600k. |
| **v2.2.0** | **Web UI + Recovery** | 🚀 **Hiện tại (Current)** | Vault **v2 envelope** (DEK + bọc kép password/recovery), **Recovery Key 24 từ BIP39** (tạo/xoay/khôi phục bằng gõ tay hoặc nạp file `.txt`, **tự xuất file khi kích hoạt**), **rate-limit 5 lần/60s + nhật ký bảo mật**, tự migrate v1→v2 khi mở két, **không có chức năng xóa két**, **nút Help** hướng dẫn trong dashboard. (Dự kiến sau: mở khóa Windows Hello, recovery delay có hủy.) |

---

## 📄 Giấy Phép (License)

Dự án được phân phối dưới giấy phép **[MIT License](https://github.com/nguyenhungtran18/PasswordAdmin/blob/main/LICENSE)**.

Bản quyền (©) 2026 thuộc về **nguyenhungtran18**.

---

## 🤝 Đóng Góp & Hỗ Trợ (Support & Ecosystem)

* **Báo cáo lỗi & Góp ý tính năng:** [GitHub Issues](https://github.com/nguyenhungtran18/PasswordAdmin/issues)
* **Tác giả:** [nguyenhungtran18](https://github.com/nguyenhungtran18)
