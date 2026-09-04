# 🛡️ PasswordAdmin — Secure Password Manager & Credential Database

<p align="center">
  <img src="https://img.shields.io/badge/Core-TokenVector_Language-blueviolet?style=for-the-badge&logo=codeforces" alt="TokenVector Language" />
  <img src="https://img.shields.io/badge/Encryption-AES--256--GCM_Zero--Knowledge-059669?style=for-the-badge&logo=fastapi" alt="Zero-Knowledge" />
  <img src="https://img.shields.io/badge/Search-TokenVector_O(1)_Index-2563eb?style=for-the-badge" alt="TokenVector Search" />
  <img src="https://img.shields.io/badge/Interface-Modern_Web_UI_(Light_Mode)-0f172a?style=for-the-badge&logo=html5" alt="Web UI" />
  <img src="https://img.shields.io/badge/License-MIT-amber?style=for-the-badge" alt="License" />
</p>

> **PasswordAdmin** là giải pháp quản lý cơ sở dữ liệu mật khẩu và tài khoản an toàn cấp doanh nghiệp (Enterprise-Grade). Ứng dụng sở hữu nhân xử lý mật mã học và cấu trúc dữ liệu tra cứu siêu tốc được viết hoàn toàn bằng ngôn ngữ lập trình **[TokenVector](https://github.com/nguyenhungtran18/TokenVector)**, kết hợp cùng giao diện **Web UI hiện đại** (nền trắng chữ đen, tương phản cao, trực quan).

---

## ⚡ Điểm Nhấn Công Nghệ: TokenVector Core Engine

Trái tim của PasswordAdmin được xây dựng và tối ưu hóa dựa trên nền tảng **[TokenVector Language](https://github.com/nguyenhungtran18/TokenVector)**:

* 🚀 **Truy Vấn $O(1)$ Siêu Tốc:** Cấu trúc bảng chỉ mục đảo ngược (Inverted Index) và phân rã Token Vector giúp lọc, định danh ứng dụng và tài khoản ngay lập tức mà không cần quét tuần tự toàn bộ database.
* 🔒 **Bảo Vệ Bộ Nhớ & An Toàn Bộ Đệm:** TokenVector được thiết kế hướng an toàn bộ nhớ (Memory Safety), ngăn chặn hoàn toàn các lỗ hổng tràn bộ đệm (Buffer Overflow) và rò rỉ con trỏ.
* 📦 **Biên Dịch Native AOT:** Mã nguồn `.tkv` có thể được biên dịch trực tiếp sang mã máy nhị phân PE (`.exe`) thông qua trình biên dịch `tkvc.exe` độc lập, vận hành không phụ thuộc runtime cồng kềnh.

🔗 *Khám phá và đóng góp cho ngôn ngữ tại:* **[https://github.com/nguyenhungtran18/TokenVector](https://github.com/nguyenhungtran18/TokenVector)**

---

## ✨ Tính Năng Nổi Bật

### 1. 🗄️ Quản Lý Cơ Sở Dữ Liệu Tài Khoản Toàn Diện (Database Management)
* **Quy Trình Tạo Key Chuẩn Mực:**
  * **Bước 1:** Khai báo bắt buộc **Tên Ứng Dụng / Dịch Vụ** (Google, GitHub, Binance, AWS...) và **Tên Tài Khoản / Email / Username**.
  * **Bước 2:** Tạo hoặc nhập Mật Khẩu bảo mật, phân loại danh mục (Công việc, Cá nhân, Tài chính, Server/Cloud).
* **Tìm Kiếm Đa Trường Thời Gian Thực:**
  * Bộ lọc kép linh hoạt: Tìm độc lập hoặc kết hợp đồng thời theo **Tên App** và **Tên User**.
* **Auto-Purge Clipboard (10 Giây Tự Hủy):**
  * Khi sao chép mật khẩu, hệ thống tự động xóa sạch clipboard sau 10 giây để triệt tiêu nguy cơ rình rập từ mã độc clipboard hijacker.
* **Két Sắt Zero-Knowledge (Master Vault):**
  * Mã hóa đầu cuối bằng thuật toán băm bảo mật SHA-256. Dữ liệu chỉ được mở khóa khi có Master Password.
* **Sao Lưu & Phục Hồi Dễ Dàng:**
  * Hỗ trợ Export Database ra tệp JSON dự phòng và Import Database chỉ với 1 thao tác.

### 2. 🎲 Bộ Sinh Mật Khẩu Ngẫu Nhiên CSPRNG "Không Thể Phá"
* **CSPRNG (Cryptographically Secure Pseudo-Random Number Generator):** Thu thập entropy thực tế từ phần cứng OS thông qua `crypto.getRandomValues`.
* **Tùy Biến Độ Dài:** Thanh trượt điều chỉnh từ 10 đến 64 ký tự.
* **Bộ Lọc Ký Tự Thông Minh:** Hỗ trợ kích hoạt chữ hoa, chữ thường, số, ký tự đặc biệt; loại trừ các ký tự dễ gây nhầm lẫn thị giác như `l, 1, I, 0, O`.
* **Thanh Đo Entropy & Ước Tính Brute-Force:**
  * Phân tích tức thì số bit Entropy ($E = L \times \log_2(N)$).
  * Dự báo thời gian bẻ khóa từ *Vài giây* đến *Hàng triệu năm* (Weak ➔ Medium ➔ Strong ➔ Unbreakable).

### 3. 🎨 Giao Diện Web UI Hiện Đại (Modern Light Theme)
* Thiết kế nền trắng chữ đen (High-Contrast Light Theme) thanh lịch, sạch sẽ và chuyên nghiệp.
* Sử dụng hệ thống UI components hiện đại:
  * **DataTable:** Bảng dữ liệu có phân trang, hỗ trợ ẩn/hiện mật khẩu dạng `••••••••`.
  * **Stat Cards:** Thống kê tổng quan số lượng tài khoản, mật khẩu an toàn, cảnh báo tài khoản cần nâng cấp.
  * **Toast Notifications:** Thông báo trạng thái thao tác mượt mà, phản hồi ngay lập tức.

---

## 🏛️ Kiến Trúc Hệ Thống (Architecture)

```
┌────────────────────────────────────────────────────────────────────────┐
│               PRESENTATION LAYER (Web UI & Desktop View)               │
│      index.html | Open_PasswordAdmin_Web.bat | ui_desktop.tkv          │
│   • Light Theme UI Components   • Dual Search (App + User)             │
│   • 10s Auto-Purge Clipboard    • Realtime Entropy & Crack Estimation  │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │
                    ┌───────────────┴───────────────┐
                    ▼                               ▼
┌───────────────────────────────────────┐ ┌───────────────────────────────┐
│     TOKENVECTOR ENGINE (.tkv)         │ │      CRYPTO ENGINE (.tkv)     │
│   • Inverted Index O(1) Search        │ │   • Hardware CSPRNG           │
│   • Tokenizer & Fast Normalization    │ │   • AES-256-GCM AEAD          │
│   • Multi-Field Filter (App & User)   │ │   • Zero-Knowledge Hashing    │
└───────────────────────────────────────┘ └───────────────┬───────────────┘
                                                          │
                                                          ▼
                                          ┌───────────────────────────────┐
                                          │     VAULT REPOSITORY (.tkv)   │
                                          │   • JSON / Database Storage   │
                                          │   • Atomic Disk Persistence   │
                                          │   • vault.tkvdb Storage       │
                                          └───────────────────────────────┘
```

---

## 📂 Cấu Trúc Thư Mục

```text
PasswordAdmin/
├── index.html                   # Giao diện Web UI hiện đại (Nền trắng chữ đen, đầy đủ UI Components)
├── Open_PasswordAdmin_Web.bat   # Script 1-click mở nhanh ứng dụng trên trình duyệt
├── PasswordAdmin.tkv            # File nguồn chính ngôn ngữ TokenVector
├── crypto_engine.tkv            # Module mật mã học & CSPRNG TokenVector
├── token_vector_engine.tkv      # Module chỉ mục & tìm kiếm $O(1)$ TokenVector
├── vault_repository.tkv         # Module lưu trữ & quản lý cơ sở dữ liệu két sắt
├── models.tkv                   # Định nghĩa thực thể dữ liệu (Credential, Category, Vault)
├── ui_desktop.tkv               # Engine giao diện dòng lệnh & desktop view
├── PasswordAdmin.exe            # Binary AOT đã được biên dịch sẵn
└── README.md                    # Tài liệu hướng dẫn dự án
```

---

## 🚀 Hướng Dẫn Khởi Chạy & Sử Dụng

### Cách 1: Khởi Chạy Giao Diện Web UI (Khuyến nghị)
1. **Click đúp** vào file `Open_PasswordAdmin_Web.bat` hoặc mở trực tiếp `index.html` trong bất kỳ trình duyệt nào (Chrome, Edge, Firefox).
2. Nhập **Master Password** để mở khóa két sắt bảo mật.
3. Bấm **"Tạo Key Mới"**:
   - Nhập **Tên App / Dịch vụ** và **Tên User**.
   - Bấm **"Tạo Ngẫu Nhiên (CSPRNG)"** để sinh mật khẩu siêu an toàn.
   - Bấm **"Lưu Vào Database"**.
4. Sử dụng 2 ô tìm kiếm để tra cứu nhanh thông tin khi cần.
5. Bấm nút **Copy**: Mật khẩu sẽ tự động bị xóa khỏi bộ nhớ đệm sau 10 giây.

### Cách 2: Vận Hành Bằng TokenVector CLI & Biên Dịch Native
Nếu bạn đã cài đặt bộ công cụ phát triển **[TokenVector SDK](https://github.com/nguyenhungtran18/TokenVector)**:

```bash
# Biên dịch AOT ra binary thực thi native độc lập:
tkvc.exe PasswordAdmin.tkv -o PasswordAdmin.exe

# Chạy ứng dụng console:
.\PasswordAdmin.exe
```

---

## 🔐 Cam Kết Bảo Mật (Security Model)

* **Zero-Knowledge Architecture:** Mật khẩu chính và các khóa bảo mật của bạn không bao giờ được gửi lên bất kỳ máy chủ bên thứ ba nào.
* **Không Lưu Plaintext:** Dữ liệu mật khẩu luôn được kiểm soát trong vùng nhớ an toàn hoặc mã hóa trước khi lưu đĩa.
* **Bộ Đệm Tự Hủy:** Ngăn ngừa tấn công đọc lén Clipboard sau khi người dùng thực hiện đăng nhập.

---

## 👨‍💻 Tác Giả & Bản Quyền

* **Tác giả:** [nguyenhungtran18](https://github.com/nguyenhungtran18)
* **Hệ sinh thái TokenVector:** [https://github.com/nguyenhungtran18/TokenVector](https://github.com/nguyenhungtran18/TokenVector)
* **Giấy phép:** [MIT License](LICENSE)
