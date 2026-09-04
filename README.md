# PasswordAdmin (Enterprise Credential Vault & Smart Password Generator) <sup>v2.0.0</sup>

---

**Cơ sở dữ liệu quản lý tài khoản & công cụ tạo mật khẩu bảo mật cao (Zero-Knowledge & CSPRNG).**  
**Tạo và quản lý thông tin đăng nhập với quy trình chuẩn mực — an toàn tuyệt đối, cục bộ hoàn toàn, không phụ thuộc máy chủ trung gian.**

**Local-First & Zero-Knowledge by Design**: Khác với các trình quản lý mật khẩu truyền thống lưu trữ dữ liệu trên đám mây của bên thứ ba, **PasswordAdmin** hoạt động hoàn toàn cục bộ trên máy của bạn. Khóa bí mật không bao giờ rời khỏi thiết bị. Mọi thao tác mã hóa, băm mật khẩu và giải mã đều được thực hiện trực tiếp tại chỗ — **không server, không cloud, không lo ngại rò rỉ dữ liệu**.

---

[![GitHub Repo](https://img.shields.io/badge/GitHub-nguyenhungtran18%2FPasswordAdmin-181717?style=flat-square&logo=github)](https://github.com/nguyenhungtran18/PasswordAdmin)
[![Core Language](https://img.shields.io/badge/Core_Engine-TokenVector-blueviolet?style=flat-square&logo=codeforces)](https://github.com/nguyenhungtran18/TokenVector)
[![Architecture](https://img.shields.io/badge/Architecture-Native_AOT_+_Web_UI-0284c7?style=flat-square)](https://github.com/nguyenhungtran18/PasswordAdmin)
[![Encryption](https://img.shields.io/badge/Security-Zero--Knowledge_SHA--256-059669?style=flat-square)](https://github.com/nguyenhungtran18/PasswordAdmin)
[![Interface](https://img.shields.io/badge/Theme-Modern_Light_Mode-0f172a?style=flat-square)](https://github.com/nguyenhungtran18/PasswordAdmin)
[![License: MIT](https://img.shields.io/badge/License-MIT-amber?style=flat-square)](https://github.com/nguyenhungtran18/PasswordAdmin/blob/main/LICENSE)

---

## ⚠️ Lưu Ý Quan Trọng (Security Disclaimer)

**Bằng việc sử dụng phần mềm này, bạn hiểu và đồng ý với các nguyên tắc bảo mật Zero-Knowledge sau:**

* **Không có cơ chế "Quên Mật Khẩu":** Mật khẩu chính (**Master Password**) là chìa khóa duy nhất để mã hóa và giải mã dữ liệu của bạn. Không ai — kể cả tác giả hay bất kỳ hệ thống nào — có thể khôi phục lại dữ liệu nếu bạn làm mất Master Password.
* **Tự Chủ Quyền Riêng Tư (Full Sovereignty):** Toàn bộ cơ sở dữ liệu được lưu trữ trực tiếp trên máy cục bộ của bạn (`vault.tkvdb` hoặc tệp sao lưu JSON do bạn quản lý).
* **Phần mềm được cung cấp nguyên trạng ("AS IS"):** Vui lòng lưu trữ Master Password và tạo bản sao lưu dữ liệu thường xuyên.

---

## 🚀 Trụ Cột Cốt Lõi: TokenVector Core Engine

Hạt nhân xử lý mật mã học và hệ thống chỉ mục tìm kiếm tốc độ cao của **PasswordAdmin** được xây dựng bằng ngôn ngữ lập trình **[TokenVector](https://github.com/nguyenhungtran18/TokenVector)**:

* ⚡ **Chỉ Mục Đảo Ngược $O(1)$ (Inverted Index Search):** Phân rã từ khóa (Tokenization) theo tên ứng dụng và tên người dùng, cho phép truy vấn bản ghi tức thời trên tập dữ liệu lớn mà không cần quét tuần tự tuyến tính $O(N)$.
* 🛡️ **An Toàn Bộ Nhớ (Memory Safety):** TokenVector triệt tiêu tận gốc các nguy cơ tràn bộ đệm (Buffer Overflow), rò rỉ con trỏ và lỗi giải phóng bộ nhớ giả mạo.
* 📦 **Biên Dịch AOT Native Độc Lập:** Mã nguồn `.tkv` được biên dịch AOT thông qua `tkvc.exe` thành binary PE native (`PasswordAdmin.exe`) 30 KB siêu nhẹ, khởi động ngay lập tức mà không cần cài đặt môi trường cồng kềnh.

🔗 **Tìm hiểu thêm về ngôn ngữ TokenVector:** [https://github.com/nguyenhungtran18/TokenVector](https://github.com/nguyenhungtran18/TokenVector)

---

## 🎯 Nguyên Tắc Vận Hành (Core Principles)

- **Quy Trình Khai Báo Nghiêm Ngặt (Mandatory Pre-Declaration):** Người dùng bắt buộc phải khai báo (1) Tên Ứng dụng/Dịch vụ và (2) Tên Người dùng/Email trước khi tiến hành tạo hoặc lưu mật khẩu.
- **Bảo Mật Bộ Đệm Tự Hủy (Auto-Purge Clipboard 10s):** Mật khẩu sao chép vào bộ nhớ tạm (Clipboard) sẽ tự động bị xóa sạch sau 10 giây để chống lại các mã độc theo dõi clipboard (Clipboard Hijackers).
- **CSPRNG Phần Cứng (True Random Generation):** Mật khẩu được sinh ngẫu nhiên dựa trên bộ tạo số ngẫu nhiên giả mật mã học với entropy từ nhân phần cứng OS (`crypto.getRandomValues`).
- **Tìm Kiếm Kép Đa Trường (Dual-Field Realtime Search):** Tra cứu độc lập hoặc kết hợp đồng thời theo Tên App và Tên User thời gian thực.
- **Giao Diện Kép Linh Hoạt (Dual-Interface):** Vừa hỗ trợ giao diện Web UI hiện đại (nền trắng chữ đen, tương phản cao, dùng ngay trên trình duyệt), vừa hỗ trợ Native CLI cho môi trường dòng lệnh/terminal.

---

## 💎 Những Điều Bạn Có Thể Làm (What You Can Do)

1. **Tạo Mật Khẩu Chuẩn Quy Trình:** Nhập thông tin App & User trước, sau đó bấm tạo mật khẩu ngẫu nhiên CSPRNG với 1 click.
2. **Tùy Biến Độ Dài & Độ Phức Tạp:** Điều chỉnh độ dài linh hoạt (10 đến 64 ký tự), bật/tắt ký tự đặc biệt, chữ số, loại bỏ ký tự dễ nhầm lẫn (`l`, `1`, `I`, `0`, `O`).
3. **Đo Lường Entropy Thời Gian Thực:** Thước đo Entropy toán học ($E = L \times \log_2(N)$) và ước tính thời gian Brute-force bẻ khóa (Weak ➔ Medium ➔ Strong ➔ Unbreakable).
4. **Quản Lý Cơ Sở Dữ Liệu Dạng Bảng (CRUD):** Xem danh sách, ẩn/hiện mật khẩu dạng `••••••••`, chỉnh sửa và xóa bản ghi với giao diện DataTable trực quan.
5. **Sao Lưu & Di Chuyển Dữ Liệu (Backup & Restore):** Xuất toàn bộ cơ sở dữ liệu ra định dạng JSON hoặc nạp tệp sao lưu để khôi phục chỉ trong 1 thao tác.
6. **Bảo Vệ Bằng Két Sắt Master Vault:** Khóa toàn bộ ứng dụng khi rời máy tính, giải mã lại tức thì bằng Master Password.

---

## 🔬 Nền Tảng Kỹ Thuật (Technical Foundation)

### So sánh & Thông số Kỹ thuật:

| Thành phần | Đặc tả kỹ thuật | Mục đích & Lợi ích |
|:---|:---|:---|
| **Core Language** | **[TokenVector](https://github.com/nguyenhungtran18/TokenVector)** (`.tkv`) | An toàn bộ nhớ, cú pháp tinh gọn, hiệu năng tiệm cận C/C++ |
| **Search Engine** | Inverted Index TokenVector ($O(1)$) | Tìm kiếm siêu tốc theo Tên App và Tên User |
| **CSPRNG Engine** | OS Hardware Entropy Pool | Sinh mật khẩu có độ hỗn loạn tối đa, không thể đoán trước |
| **Vault Encryption** | PBKDF2 / SHA-256 Digest | Zero-Knowledge authentication & bảo vệ két sắt |
| **Web Presentation** | HTML5 + Tailwind CSS + Lucide Icons | Nền trắng chữ đen (Light Mode), tương phản cao, không phụ thuộc server |
| **Auto-Purge Timer** | 10.000 ms (10 giây) | Xóa sạch clipboard tự động sau khi copy |

### Bảng Ký Tự Tiêu Chuẩn (Google & Enterprise Compatible):
```text
abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_=+[]{}|;:,.<>?
```

### Tiêu Chuẩn Đánh Giá Mật Khẩu (Password Strength Scale):
- **Cực Mạnh (Unbreakable):** $\ge 85\text{ bits}$ Entropy — Kháng tấn công siêu máy tính trong hàng triệu năm.
- **Tốt (Safe):** $65 - 84\text{ bits}$ Entropy — An toàn trước mọi cuộc tấn công phân tán trong nhiều thế kỷ.
- **Trung Bình:** $40 - 64\text{ bits}$ Entropy — Khuyến cáo nâng cấp độ dài và thêm ký tự đặc biệt.
- **Yếu (Danger):** $< 40\text{ bits}$ Entropy — Có thể bị crack trong vài giây hoặc vài phút.

---

## 📥 Hướng Dẫn Tải & Cài Đặt (Download & Setup)

### 1. Tải Gói Cài Đặt Sẵn (Pre-built Release)
Tải phiên bản đóng gói sẵn chính thức từ GitHub Release:

📦 **Link Tải Trực Tiếp:** 👉 **[PasswordAdmin.zip (v2.0.0)](https://github.com/nguyenhungtran18/PasswordAdmin/releases/download/v2.0.0/PasswordAdmin.zip)**

---

### 2. Hướng Dẫn Giải Nén
1. Sau khi tải tệp `PasswordAdmin.zip`, nhấp chuột phải vào tệp và chọn **Extract All...** (hoặc sử dụng phần mềm 7-Zip / WinRAR chọn **Extract to PasswordAdmin**).
2. Chọn thư mục lưu trữ thuận tiện trên máy tính (ví dụ: `D:\PasswordAdmin` hoặc `C:\Tools\PasswordAdmin`).
3. Mở thư mục vừa giải nén, bạn sẽ thấy các tệp: `index.html`, `Open_PasswordAdmin_Web.bat`, `PasswordAdmin.exe`, `README.md`, v.v.

---

### 3. Hướng Dẫn Vào Phần Mềm Lần Đầu Tiên (First-Time Setup)

1. **Khởi chạy ứng dụng:**
   - Nhấp đúp chuột vào tệp **`Open_PasswordAdmin_Web.bat`** (hoặc nhấp đúp trực tiếp vào tệp **`index.html`**).
   - Ứng dụng sẽ tự động mở trên trình duyệt mặc định (Google Chrome, Microsoft Edge, Firefox, Brave) với giao diện nền trắng chữ đen sắc nét.

2. **Khởi tạo Master Password (Mật khẩu chính bảo vệ két sắt):**
   - Tại màn hình hộp thoại **Két Sắt Mật Khẩu (Vault)**, bạn nhập mật khẩu chính muốn thiết lập vào ô *Master Password*.
   - 💡 *Lưu ý quan trọng:* Vì hệ thống tuân thủ mô hình bảo mật Zero-Knowledge, mật khẩu bạn nhập trong lần khởi chạy đầu tiên này sẽ được băm bảo mật (SHA-256) và trở thành **Master Key** bảo vệ toàn bộ cơ sở dữ liệu. Vui lòng ghi nhớ mật khẩu này!
   - Bấm nút **"Mở Khóa Cơ Sở Dữ Liệu"** để vào giao diện quản trị chính.

3. **Tạo tài khoản & mật khẩu đầu tiên:**
   - Bấm nút **"Tạo Key Mới"** (màu xanh ở góc phải trên).
   - **Bước 1 (Khai báo bắt buộc):** Nhập *Tên Ứng Dụng / Dịch Vụ* (ví dụ: `Google`, `GitHub`, `Binance`...) và *Tên Người Dùng / Email* (ví dụ: `security_admin@gmail.com`).
   - **Bước 2 (Tạo Key):** Bấm nút **"Tạo Ngẫu Nhiên (CSPRNG)"** để phần mềm tự động tính toán và sinh mật khẩu 20 ký tự đạt mức *Cực Mạnh (Unbreakable)*, hoặc tự nhập mật khẩu riêng của bạn.
   - Bấm **"Lưu Vào Database"** để hoàn tất bản ghi đầu tiên!

4. **Sao chép an toàn với Auto-Purge Clipboard:**
   - Tại dòng tài khoản vừa lưu, bấm biểu tượng **Copy**.
   - Mật khẩu sẽ được sao chép vào bộ nhớ đệm và **tự động bị xóa vĩnh viễn khỏi Clipboard sau 10 giây** để bảo vệ an toàn.

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
├── index.html                   # Ứng dụng Web UI (Light Theme, đầy đủ UI Components)
├── Open_PasswordAdmin_Web.bat   # Phím tắt 1-click mở ứng dụng tức thì trên Windows
├── PasswordAdmin.tkv            # Tệp điều phối chính ngôn ngữ TokenVector
├── crypto_engine.tkv            # Module mật mã học & CSPRNG TokenVector
├── token_vector_engine.tkv      # Module chỉ mục & tìm kiếm O(1) TokenVector
├── vault_repository.tkv         # Module lưu trữ & quản lý database két sắt
├── models.tkv                   # Định nghĩa thực thể dữ liệu (Credential, Category, Vault)
├── ui_desktop.tkv               # Engine giao diện desktop & terminal CLI
├── PasswordAdmin.exe            # Binary AOT 30 KB biên dịch sẵn từ TokenVector
├── vault.tkvdb                  # Tệp cơ sở dữ liệu két sắt cục bộ
├── LICENSE                      # Giấy phép MIT License
└── README.md                    # Tài liệu hướng dẫn sử dụng & đặc tả kỹ thuật
```

---

## 🛡️ Yêu Cầu Bảo Mật Khuyến Nghị (Security Best Practices)

### Quy Tắc Đặt Master Password:
- Tối thiểu 12 đến 16 ký tự trở lên.
- Kết hợp chữ hoa, chữ thường, số và ký tự đặc biệt.
- Tuyệt đối không chia sẻ hoặc lưu Master Password ở dạng văn bản thuần (plaintext) trên máy tính.

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
| **v2.0.0** | **TokenVector + Web UI** | 🚀 **Hiện tại (Current)** | Thêm Web UI nền trắng chữ đen với đầy đủ UI Components, chuẩn hóa luồng nhập App/User trước khi tạo Key, thanh tìm kiếm kép, đếm ngược 10s Auto-Purge Clipboard. |

---

## 📄 Giấy Phép (License)

Dự án được phân phối dưới giấy phép **[MIT License](https://github.com/nguyenhungtran18/PasswordAdmin/blob/main/LICENSE)**.

Bản quyền (©) 2026 thuộc về **nguyenhungtran18**.

---

## 🤝 Đóng Góp & Hỗ Trợ (Support & Ecosystem)

* **Báo cáo lỗi & Góp ý tính năng:** [GitHub Issues](https://github.com/nguyenhungtran18/PasswordAdmin/issues)
* **Hệ sinh thái ngôn ngữ TokenVector:** [https://github.com/nguyenhungtran18/TokenVector](https://github.com/nguyenhungtran18/TokenVector)
* **Tác giả:** [nguyenhungtran18](https://github.com/nguyenhungtran18)
