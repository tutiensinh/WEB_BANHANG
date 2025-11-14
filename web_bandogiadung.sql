-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 14, 2025 at 06:30 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `web_bandogiadung`
--

-- --------------------------------------------------------

--
-- Table structure for table `chitietdonhang`
--

CREATE TABLE `chitietdonhang` (
  `id` int(255) NOT NULL,
  `id_donhang` int(255) NOT NULL,
  `id_sanpham` int(255) NOT NULL,
  `soluong` int(255) NOT NULL,
  `dongia` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chitietdonhang`
--

INSERT INTO `chitietdonhang` (`id`, `id_donhang`, `id_sanpham`, `soluong`, `dongia`) VALUES
(4, 4, 99, 2, 3900000.00);

-- --------------------------------------------------------

--
-- Table structure for table `donhang`
--

CREATE TABLE `donhang` (
  `id` int(255) NOT NULL,
  `id_taikhoan` int(255) NOT NULL,
  `ngaydat` datetime NOT NULL,
  `diachi` varchar(300) NOT NULL,
  `email` varchar(100) NOT NULL,
  `tongtien` decimal(12,2) NOT NULL,
  `trangthai` enum('Chờ xử lý','Đang giao','Hoàn thành','Hủy') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `donhang`
--

INSERT INTO `donhang` (`id`, `id_taikhoan`, `ngaydat`, `diachi`, `email`, `tongtien`, `trangthai`) VALUES
(4, 4, '2025-11-09 01:40:22', 'Phu Tho, ha noi', 'nta123@gmail.com', 7800000.00, 'Hoàn thành'),
(5, 4, '2025-11-09 01:42:13', 'Phu Tho', 'nta123@gmail.com', 3780000.00, 'Hoàn thành');

-- --------------------------------------------------------

--
-- Table structure for table `giohang`
--

CREATE TABLE `giohang` (
  `id` int(255) NOT NULL,
  `id_taikhoan` int(255) NOT NULL,
  `id_sanpham` int(255) NOT NULL,
  `soluong` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lienhe`
--

CREATE TABLE `lienhe` (
  `id` int(255) NOT NULL,
  `hoten` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `noidung` text NOT NULL,
  `ngaygui` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lienhe`
--

INSERT INTO `lienhe` (`id`, `hoten`, `email`, `noidung`, `ngaygui`) VALUES
(1, 'Nguyễn Việt Anh ', 'nguyentunb1@gmail.com', 'đơn hàng đến hơi chậm', '2025-11-11 09:51:27');

-- --------------------------------------------------------

--
-- Table structure for table `sanpham`
--

CREATE TABLE `sanpham` (
  `id` int(255) NOT NULL,
  `tensp` varchar(200) NOT NULL,
  `mota` text NOT NULL,
  `dongia` decimal(10,2) NOT NULL,
  `hinhanh` varchar(200) NOT NULL,
  `loai` varchar(100) NOT NULL,
  `tonkho` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sanpham`
--

INSERT INTO `sanpham` (`id`, `tensp`, `mota`, `dongia`, `hinhanh`, `loai`, `tonkho`) VALUES
(1, 'Nồi cơm điện Cuckoo 1.8L CR-1020F', 'Nồi cơm điện tử, lòng nồi chống dính', 1890000.00, 'images/products/rice-cooker-1.jpg', 'Nhà bếp', 55),
(2, 'Nồi cơm cao tần Toshiba 1.5L RC-15VXR', 'Công nghệ IH, nấu cơm cháy, giữ ấm 48h', 4200000.00, 'images/products/rice-cooker-2.jpg', 'Nhà bếp', 55),
(3, 'Máy xay sinh tố Philips HR2118', 'Cối thủy tinh 1.5L, 5 tốc độ, nhồi', 1290000.00, 'images/products/blender-1.jpg', 'Nhà bếp', 70),
(4, 'Máy xay đa năng Panasonic MX-AC400WRA', 'Xay sinh tố, xay thịt, xay đồ khô', 1990000.00, 'images/products/blender-2.jpg', 'Nhà bếp', 45),
(5, 'Lò vi sóng Sharp 20L R-205VN-S', 'Có nướng, công suất 800W, rã đông nhanh', 1750000.00, 'images/products/microwave-1.jpg', 'Nhà bếp', 40),
(6, 'Lò vi sóng điện tử Samsung 23L MG23K3515AS/SV', 'Lòng gốm Ceramic, hẹn giờ', 2490000.00, 'images/products/microwave-2.jpg', 'Nhà bếp', 35),
(7, 'Ấm đun siêu tốc Lock&Lock 1.7L EJK341', 'Chất liệu inox 304 an toàn, tự ngắt khi sôi', 650000.00, 'images/products/kettle-1.jpg', 'Nhà bếp', 100),
(8, 'Bếp từ đôi Kangaroo KG855i', 'Mặt kính Ceramic, công suất 4000W', 5990000.00, 'images/products/induction-hob-1.jpg', 'Nhà bếp', 25),
(9, 'Bếp từ đơn Sunhouse SHD6150', 'Nhỏ gọn, phím cảm ứng, tặng kèm nồi lẩu', 790000.00, 'images/products/induction-hob-2.jpg', 'Nhà bếp', 60),
(10, 'Nồi chiên không dầu Philips 6.2L HD9270/90', 'Công nghệ Rapid Air, giảm 90% chất béo', 3800000.00, 'images/products/air-fryer-1.jpg', 'Nhà bếp', 40),
(11, 'Nồi chiên không dầu Lock&Lock 7L EJF881', 'Dung tích cực lớn, bảng điều khiển điện tử', 3190000.00, 'images/products/air-fryer-2.jpg', 'Nhà bếp', 30),
(12, 'Máy pha cà phê Delonghi EC685.M', 'Pha Espresso, Cappuccino chuyên nghiệp', 5500000.00, 'images/products/coffee-maker-1.jpg', 'Nhà bếp', 20),
(13, 'Máy ép chậm Hurom HZ-SBE17', 'Ép kiệt bã, giữ nguyên vitamin', 8500000.00, 'images/products/blender-3.jpg', 'Nhà bếp', 15),
(14, 'Lò nướng Sanaky 50L VH-5099S2D', 'Có quạt đối lưu, 2 thanh nhiệt, xiên quay', 2300000.00, 'images/products/oven-1.jpg', 'Nhà bếp', 25),
(15, 'Bếp nướng điện không khói Sunhouse SHD4607', 'Mặt bếp phủ chống dính Whitford (USA)', 890000.00, 'images/products/oven-2.jpg', 'Nhà bếp', 40),
(16, 'Máy đánh trứng cầm tay Bosch MFQ4030', 'Công suất 500W, 5 tốc độ, que trộn inox', 1450000.00, 'images/products/blender-4.jpg', 'Nhà bếp', 50),
(17, 'Máy làm sữa hạt Unie V8S', 'Tự động xay nấu, vệ sinh máy', 2990000.00, 'images/products/blender-5.jpg', 'Nhà bếp', 20),
(18, 'Ấm đun siêu tốc thông minh Xiaomi', 'Điều khiển qua app, giữ nhiệt 12h', 990000.00, 'images/products/kettle-2.jpg', 'Nhà bếp', 30),
(19, 'Tủ lạnh Samsung Inverter 256L RT25M4032BU/SV', 'Ngăn đông mềm -1°C, tiết kiệm điện', 7490000.00, 'images/products/fridge-1.jpg', 'Gia dụng lớn', 20),
(20, 'Tủ lạnh Side by Side LG 601L GR-D247JDS', 'Lấy nước ngoài, Inverter, khử mùi Nano', 18990000.00, 'images/products/fridge-2.jpg', 'Gia dụng lớn', 35),
(21, 'Máy giặt cửa trước LG 9kg FV1409S4W', 'Công nghệ AI DD, giặt hơi nước diệt khuẩn', 8990000.00, 'images/products/washing-machine-1.jpg', 'Gia dụng lớn', 15),
(22, 'Máy giặt cửa trên Panasonic 10kg NA-F100A9BRV', 'Mâm giặt Ag+, giặt nhanh', 6200000.00, 'images/products/washing-machine-2.jpg', 'Gia dụng lớn', 25),
(23, 'Máy sấy bơm nhiệt Electrolux 8kg EDH803R7WB', 'Sấy Heat Pump, tiết kiệm điện', 12500000.00, 'images/products/washing-machine-3.jpg', 'Gia dụng lớn', 10),
(24, 'Tủ lạnh mini Aqua 90L AQR-D99FA(BS)', 'Nhỏ gọn, phù hợp phòng trọ, khách sạn', 2690000.00, 'images/products/fridge-3.jpg', 'Gia dụng lớn', 30),
(25, 'Máy rửa bát Bosch SMS46NI05E', '13 bộ, sấy Zeolith, SuperSilence', 19500000.00, 'images/products/oven-3.jpg', 'Gia dụng lớn', 15),
(26, 'Tủ đông Sanaky 260L VH-2899A3', 'Dàn đồng, 2 ngăn (đông, mát)', 5800000.00, 'images/products/fridge-4.jpg', 'Gia dụng lớn', 15),
(27, 'Robot hút bụi Xiaomi Roborock S7', 'Lau rung, tự động nâng giẻ, lực hút 2500Pa', 11990000.00, 'images/products/vacuum-robot-1.jpg', 'Làm sạch', 20),
(28, 'Robot hút bụi Ecovacs Deebot T9', 'Làm sạch gấp 4, khử mùi Air Freshener', 9500000.00, 'images/products/vacuum-robot-2.jpg', 'Làm sạch', 15),
(29, 'Máy hút bụi không dây Dyson V11 Fluffy', 'Lực hút mạnh nhất, pin 60 phút', 15990000.00, 'images/products/vacuum-handheld-1.jpg', 'Làm sạch', 10),
(30, 'Máy hút bụi cầm tay Deerma DX700S', 'Công suất 600W, bộ lọc HEPA', 790000.00, 'images/products/vacuum-handheld-2.jpg', 'Làm sạch', 60),
(31, 'Máy lọc không khí Xiaomi 4 Pro', 'Lọc bụi mịn PM2.5, diện tích 60m²', 4190000.00, 'images/products/air-purifier-1.jpg', 'Làm sạch', 30),
(32, 'Máy lọc không khí Sharp FP-J30E-A', 'Công nghệ Plasmacluster ion, khử mùi', 2190000.00, 'images/products/air-purifier-2.jpg', 'Làm sạch', 50),
(33, 'Bàn ủi hơi nước đứng Philips GC518', 'Công suất 1600W, 5 chế độ phun hơi', 2200000.00, 'images/products/steam-iron-1.jpg', 'Làm sạch', 35),
(34, 'Bàn ủi hơi nước cầm tay Tefal DT8100', 'Gọn nhẹ, làm nóng nhanh 40s', 1590000.00, 'images/products/steam-iron-2.jpg', 'Làm sạch', 40),
(35, 'Máy hút ẩm Sharp 12L DW-D12A-W', 'Kiểm soát độ ẩm, sấy quần áo', 5500000.00, 'images/products/air-purifier-3.jpg', 'Làm sạch', 20),
(36, 'Quạt cây Mitsubishi LV16-RV', 'Điều khiển từ xa, 3 tốc độ gió', 1990000.00, 'images/products/fan-1.jpg', 'Gia dụng khác', 50),
(37, 'Quạt điều hòa Sunhouse SHD7721', 'Dung tích 30L, làm mát nhanh', 3100000.00, 'images/products/fan-2.jpg', 'Gia dụng khác', 25),
(38, 'Smart Tivi Samsung 4K 55 inch UA55AU7700', 'Vi xử lý Crystal 4K, Tizen OS', 11500000.00, 'images/products/television-1.jpg', 'Giải trí', 30),
(39, 'Smart Tivi LG 4K 50 inch 50UQ7550PSF', 'WebOS, điều khiển giọng nói', 9890000.00, 'images/products/television-2.jpg', 'Giải trí', 25),
(40, 'Máy sấy tóc ion âm Panasonic EH-NE65-K645', 'Công suất 2000W, bảo vệ tóc', 850000.00, 'images/products/steam-iron-3.jpg', 'Gia dụng khác', 70),
(41, 'Cân sức khỏe điện tử Xiaomi Mi Scale 2', 'Đo 13 chỉ số cơ thể, kết nối app', 690000.00, 'images/products/kettle-3.jpg', 'Gia dụng khác', 80),
(42, 'Ổ cắm thông minh Điện Quang', 'Hẹn giờ bật tắt, điều khiển qua Wifi', 350000.00, 'images/products/kettle-4.jpg', 'Gia dụng khác', 100),
(43, 'Quạt trần 5 cánh Panasonic F-60WWK', 'Động cơ DC, êm ái, tiết kiệm điện', 4800000.00, 'images/products/fan-3.jpg', 'Gia dụng khác', 20),
(44, 'Máy nước nóng Ariston 20L AN2 20 RS 2.5 FE', 'Làm nóng gián tiếp, thanh đốt đồng', 2790000.00, 'images/products/oven-4.jpg', 'Gia dụng khác', 30),
(45, 'Loa Bluetooth Marshall Stanmore II', 'Thiết kế cổ điển, âm thanh mạnh mẽ', 8990000.00, 'images/products/television-3.jpg', 'Giải trí', 15),
(46, 'Combo Nồi cơm + Ấm siêu tốc (Giá sốc)', 'Mua 1 được 2, tiết kiệm hơn', 1990000.00, 'images/products/rice-cooker-3.jpg', 'Khuyến mãi', 20),
(47, 'Lò vi sóng (Hàng trưng bày, giảm 40%)', 'Lò vi sóng Sharp 20L mới 99%', 1050000.00, 'images/products/microwave-3.jpg', 'Khuyến mãi', 5),
(48, 'Máy lọc không khí (Giảm giá cuối tuần)', 'Máy lọc không khí Sharp FP-J30E-A', 1990000.00, 'images/products/air-purifier-4.jpg', 'Khuyến mãi', 15),
(49, 'Bếp từ đơn (Tặng nồi lẩu)', 'Bếp từ Sunhouse SHD6150 giá không đổi', 790000.00, 'images/products/induction-hob-3.jpg', 'Khuyến mãi', 50),
(50, 'Máy hút bụi Deerma (Sale sập sàn)', 'Máy hút bụi cầm tay Deerma DX700S', 599000.00, 'images/products/vacuum-handheld-3.jpg', 'Khuyến mãi', 30),
(51, 'Nồi cơm cao tần Tiger 1L JKT-S10W', 'Lòng nồi 8 lớp, 11 chế độ nấu', 7800000.00, 'images/products/rice-cooker-4.jpg', 'Nhà bếp', 15),
(52, 'Máy ép trái cây Panasonic MJ-L500SRA', 'Ép kiệt bã 90%, giữ nguyên vitamin', 4500000.00, 'images/products/blender-6.jpg', 'Nhà bếp', 25),
(53, 'Ấm siêu tốc thủy tinh Philips HD9339/80', 'Dung tích 1.7L, đèn LED xanh khi đun', 1190000.00, 'images/products/kettle-5.jpg', 'Nhà bếp', 60),
(54, 'Nồi chiên không dầu Cosori 3.5L', '11 chế độ cài đặt sẵn, điều khiển điện tử', 2100000.00, 'images/products/air-fryer-3.jpg', 'Nhà bếp', 40),
(55, 'Máy trộn bột cầm tay KitchenAid 7 tốc độ', 'Que trộn thép không gỉ, động cơ mạnh mẽ', 1900000.00, 'images/products/blender-7.jpg', 'Nhà bếp', 30),
(56, 'Máy xay cà phê hạt Delonghi KG79', 'Xay mịn đều với 16 mức độ', 1350000.00, 'images/products/coffee-maker-2.jpg', 'Nhà bếp', 35),
(57, 'Lò nướng đối lưu Electrolux 30L EOT30MXC', '6 chế độ nướng, vỏ thép không gỉ', 2400000.00, 'images/products/oven-5.jpg', 'Nhà bếp', 22),
(58, 'Tủ lạnh Samsung Side by Side 655L RS62R5001M9/SV', 'Lấy nước ngoài, làm đá tự động', 19990000.00, 'images/products/fridge-5.jpg', 'Gia dụng lớn', 10),
(59, 'Máy giặt cửa trên Toshiba 10kg AW-UK1100GV', 'Công nghệ GreatWaves, giặt siêu sạch', 7200000.00, 'images/products/washing-machine-4.jpg', 'Gia dụng lớn', 18),
(60, 'Máy rửa bát độc lập Electrolux ESF6010BW', '8 bộ, 6 chương trình rửa', 9500000.00, 'images/products/oven-6.jpg', 'Gia dụng lớn', 12),
(61, 'Máy sấy thông hơi Electrolux 7.5kg EDV754H3WB', 'Cảm biến Smart Sensor, sấy nhanh 40 phút', 6990000.00, 'images/products/washing-machine-5.jpg', 'Gia dụng lớn', 20),
(62, 'Bình nước nóng Ariston 30L AN2 30RS', 'Làm nóng gián tiếp, ELCB chống giật', 3100000.00, 'images/products/kettle-6.jpg', 'Gia dụng lớn', 40),
(63, 'Máy hút bụi dạng hộp Panasonic MC-CL575KN49', 'Công suất 2000W, bộ lọc HEPA 7 lớp', 2900000.00, 'images/products/vacuum-handheld-4.jpg', 'Làm sạch', 30),
(64, 'Cây lau nhà hơi nước Deerma ZQ610', 'Diệt 99.9% vi khuẩn bằng hơi nóng 150°C', 1600000.00, 'images/products/steam-iron-4.jpg', 'Làm sạch', 35),
(65, 'Máy lọc không khí Dyson Purifier Cool TP07', 'Lọc HEPA 360°, kiêm quạt không cánh', 14500000.00, 'images/products/air-purifier-5.jpg', 'Làm sạch', 10),
(66, 'Máy hút bụi mini Xiaomi Mi Vacuum Cleaner Mini', 'Nhỏ gọn, dùng cho ô tô, sofa, bàn phím', 950000.00, 'images/products/vacuum-handheld-5.jpg', 'Làm sạch', 50),
(67, 'Smart Tivi OLED LG 4K 55 inch 55C2PSA', 'Màn hình OLED evo, chip α9 Gen5 AI', 28900000.00, 'images/products/television-4.jpg', 'Giải trí', 8),
(68, 'Loa thanh Soundbar Samsung HW-Q700B', 'Âm thanh vòm 3.1.2 kênh, Dolby Atmos', 7500000.00, 'images/products/television-5.jpg', 'Giải trí', 20),
(69, 'Máy sấy tóc Dyson Supersonic HD08', 'Kiểm soát nhiệt thông minh, 5 đầu sấy', 11500000.00, 'images/products/steam-iron-5.jpeg', 'Gia dụng khác', 15),
(70, 'Quạt đứng Senko DR1608', 'Màu kem môn, remote điều khiển từ xa', 680000.00, 'images/products/fan-4.jpg', 'Gia dụng khác', 70),
(71, 'Google Tivi Xiaomi 4K 43 inch A Pro', 'Hệ điều hành Google TV, viền kim loại', 6490000.00, 'images/products/television-6.jpg', 'Giải trí', 30),
(72, 'Máy cạo râu Philips S1103/02', 'Lưỡi cạo tự mài, cạo khô và ướt', 850000.00, 'images/products/steam-iron-6.jpg', 'Gia dụng khác', 40),
(73, 'Combo Bếp từ + Nồi chiên (Giảm 30%)', 'Tiết kiệm chi phí cho căn bếp mới', 3500000.00, 'images/products/induction-hob-4.jpg', 'Khuyến mãi', 15),
(74, 'Quạt sưởi gốm Ceramic (Thanh lý 50%)', 'Hàng trưng bày, sưởi ấm nhanh, an toàn', 990000.00, 'images/products/fan-5.jpg', 'Khuyến mãi', 5),
(75, 'Ấm siêu tốc Sunhouse 1.8L (Giá sốc)', 'Inox 304, giá chỉ còn 199.000đ', 199000.00, 'images/products/kettle-7.jpg', 'Khuyến mãi', 100),
(76, 'Nồi áp suất điện Sunhouse 6L SHD1560', 'Hầm, nấu cháo, súp. An toàn', 1590000.00, 'images/products/rice-cooker-5.jpg', 'Nhà bếp', 40),
(77, 'Máy xay thịt Lock&Lock EJM171', 'Cối thủy tinh 1.2L, lưỡi dao kép', 890000.00, 'images/products/blender-8.jpg', 'Nhà bếp', 55),
(78, 'Lò vi sóng Electrolux 20L EMM20K18GW', 'Điều khiển cơ, 5 mức công suất', 1650000.00, 'images/products/microwave-4.jpg', 'Nhà bếp', 35),
(79, 'Bếp nướng điện Kangaroo KG699', 'Mặt đá hoa cương, không sinh khói', 1100000.00, 'images/products/oven-7.jpg', 'Nhà bếp', 30),
(80, 'Máy pha cà phê phin điện tự động', 'Giữ trọn hương vị phin truyền thống', 750000.00, 'images/products/coffee-maker-3.jpg', 'Nhà bếp', 50),
(81, 'Nồi chiên không dầu Kalite 10L Q10', 'Dung tích lớn, 10 chức năng', 2800000.00, 'images/products/air-fryer-4.jpg', 'Nhà bếp', 25),
(82, 'Bếp từ đơn Xiaomi Mi Induction Cooker', 'Thiết kế tối giản, 99 mức nhiệt', 1390000.00, 'images/products/induction-hob-5.jpg', 'Nhà bếp', 40),
(83, 'Tủ lạnh Panasonic Inverter 322L', 'Ngăn đông mềm Prime Fresh, tiết kiệm điện', 12990000.00, 'images/products/fridge-6.jpg', 'Gia dụng lớn', 15),
(84, 'Máy giặt cửa trên Aqua 9kg AQW-F91GT.S', 'Mâm giặt kháng khuẩn, vắt cực khô', 5300000.00, 'images/products/washing-machine-6.jpg', 'Gia dụng lớn', 25),
(85, 'Tủ mát Sanaky 300L VH-308K', 'Cửa kính 2 lớp, sưởi kính', 7200000.00, 'images/products/fridge-7.jpg', 'Gia dụng lớn', 10),
(86, 'Máy sấy ngưng tụ Beko 8kg DU8133GA0W', 'Không cần ống thoát, 15 chương trình', 8990000.00, 'images/products/washing-machine-7.jpg', 'Gia dụng lớn', 18),
(87, 'Lò nướng âm tủ Bosch 71L HBF534EB0K', '7 chế độ nướng, 3D Hotair', 16500000.00, 'images/products/oven-8.jpg', 'Gia dụng lớn', 8),
(88, 'Robot hút bụi lau nhà Dreame D9 Max', 'Lực hút 4000Pa, điều hướng LiDAR', 7990000.00, 'images/products/vacuum-robot-3.jpg', 'Làm sạch', 22),
(89, 'Máy lọc không khí Levoit Core 300', 'Lõi lọc 3 lớp HEPA, hiệu quả 40m²', 2890000.00, 'images/products/air-purifier-6.jpg', 'Làm sạch', 45),
(90, 'Bàn ủi hơi nước Philips EasySpeed GC1742', 'Mặt đế chống dính, công suất 2000W', 690000.00, 'images/products/steam-iron-7.jpg', 'Làm sạch', 60),
(91, 'Máy hút bụi giường nệm Deerma CM800', 'Diệt khuẩn UV, rung 8000 lần/phút', 1100000.00, 'images/products/vacuum-handheld-6.jpg', 'Làm sạch', 50),
(92, 'Máy lọc không khí Sharp 40m² FP-J50V-H', 'Plasmacluster ion mật độ cao', 4500000.00, 'images/products/air-purifier-7.jpg', 'Làm sạch', 30),
(93, 'Smart Tivi QLED Samsung 4K 55 inch QA55Q60B', 'Chấm lượng tử, 100% dải màu', 14900000.00, 'images/products/television-7.jpg', 'Giải trí', 20),
(94, 'Quạt điều hòa Kangaroo KG50F62', 'Dung tích 30L, làm mát nhanh, remote', 2990000.00, 'images/products/fan-6.jpg', 'Gia dụng khác', 33),
(95, 'Android Tivi Sony 4K 50 inch KD-50X75K', 'Google TV, chip X1, âm thanh vòm', 11900000.00, 'images/products/television-8.jpg', 'Giải trí', 25),
(96, 'Máy tăm nước Lock&Lock Cordless ENR156BLU', '3 chế độ, pin sạc, chống nước IPX7', 950000.00, 'images/products/kettle-8.jpg', 'Gia dụng khác', 70),
(97, 'Quạt sạc tích điện Sunhouse SHD7116', 'Dùng 5-8 tiếng khi mất điện', 850000.00, 'images/products/fan-7.jpg', 'Gia dụng khác', 40),
(98, 'Combo Nồi + Chảo Sunhouse (Mua 1 tặng 1)', 'Bộ nồi inox 3 đáy và chảo chống dính', 799000.00, 'images/products/induction-hob-6.jpg', 'Khuyến mãi', 50),
(99, 'Robot hút bụi (Trưng bày, giảm 60%)', 'Robot Ecovacs Deebot T9, mới 98%', 3900000.00, 'images/products/vacuum-robot-4.jpg', 'Khuyến mãi', 10),
(100, 'Mua Bếp Từ Tặng Bộ Nồi 5 Món', 'Mua Bếp từ đôi Kangaroo KG855i tặng bộ nồi', 5900000.00, 'images/products/induction-hob-7.jpg', 'Khuyến mãi', 25);

-- --------------------------------------------------------

--
-- Table structure for table `taikhoan`
--

CREATE TABLE `taikhoan` (
  `id` int(255) NOT NULL,
  `hoten` varchar(100) NOT NULL,
  `tendangnhap` varchar(100) NOT NULL,
  `matkhau` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `sodienthoai` varchar(20) NOT NULL,
  `diachi` varchar(300) NOT NULL,
  `vaitro` enum('user','admin') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `taikhoan`
--

INSERT INTO `taikhoan` (`id`, `hoten`, `tendangnhap`, `matkhau`, `email`, `sodienthoai`, `diachi`, `vaitro`) VALUES
(2, 'Nguyễn Việt Anh ', 'Vanh', 'admin1234', 'nva@gmail.com', '0969927975', 'Gia Lâm, Hà Nội', 'user'),
(3, 'Nguyễn Ngọc Tú', 'nguyentu', '123456', 'nguyentunb1@gmail.com', '0328009638', 'Hoa Lư - Ninh Bình', 'admin'),
(4, 'Phùng Tuấn Anh', 'tanh', 'admin', 'pta@gmail.com', '096234', 'Phu Tho', 'user'),
(5, 'Trần Văn Huy', 'huylegend2k', '12345678', 'huydeptrai@gmail.com', '0986984965', 'Phường Thượng Cát, Hà Nội', 'user'),
(6, 'Phạm Linh Hương', 'linhhuong', '654321', 'plh@gmail.com', '04885995', 'Tuyên Quang', 'user');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `chitietdonhang`
--
ALTER TABLE `chitietdonhang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_ctdh_donhang` (`id_donhang`),
  ADD KEY `fk_ctdh_sanpham` (`id_sanpham`);

--
-- Indexes for table `donhang`
--
ALTER TABLE `donhang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_donhang_taikhoan` (`id_taikhoan`);

--
-- Indexes for table `giohang`
--
ALTER TABLE `giohang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_giohang_taikhoan` (`id_taikhoan`),
  ADD KEY `fk_giohang_sanpham` (`id_sanpham`);

--
-- Indexes for table `lienhe`
--
ALTER TABLE `lienhe`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sanpham`
--
ALTER TABLE `sanpham`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `taikhoan`
--
ALTER TABLE `taikhoan`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `chitietdonhang`
--
ALTER TABLE `chitietdonhang`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `donhang`
--
ALTER TABLE `donhang`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `giohang`
--
ALTER TABLE `giohang`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lienhe`
--
ALTER TABLE `lienhe`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sanpham`
--
ALTER TABLE `sanpham`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT for table `taikhoan`
--
ALTER TABLE `taikhoan`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `chitietdonhang`
--
ALTER TABLE `chitietdonhang`
  ADD CONSTRAINT `fk_ctdh_donhang` FOREIGN KEY (`id_donhang`) REFERENCES `donhang` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_ctdh_sanpham` FOREIGN KEY (`id_sanpham`) REFERENCES `sanpham` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `donhang`
--
ALTER TABLE `donhang`
  ADD CONSTRAINT `fk_donhang_taikhoan` FOREIGN KEY (`id_taikhoan`) REFERENCES `taikhoan` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `giohang`
--
ALTER TABLE `giohang`
  ADD CONSTRAINT `fk_giohang_sanpham` FOREIGN KEY (`id_sanpham`) REFERENCES `sanpham` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_giohang_taikhoan` FOREIGN KEY (`id_taikhoan`) REFERENCES `taikhoan` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
