/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

 /* global fetch, Intl */

document.addEventListener('DOMContentLoaded', function () {
                const searchInput = document.getElementById('search-input');
                const suggestionBox = document.getElementById('suggestion-box');

                // Tạo một đối tượng formatter tiền tệ (để hiển thị 50.000đ)
                const formatter = new Intl.NumberFormat('vi-VN', {
                    style: 'currency',
                    currency: 'VND'
                });

                searchInput.addEventListener('keyup', function () {
                    const query = searchInput.value;

                    if (query.length < 2) {
                        suggestionBox.style.display = 'none';
                        return;
                    }

                    // 1. Gọi Servlet (Dùng dấu + để tránh lỗi JSP)
                    fetch('search-suggest?query=' + encodeURIComponent(query))
                            .then(response => response.json())
                            .then(products => { // 2. Dữ liệu trả về giờ là một List<Product>
                                if (products.length > 0) {
                                    let html = '';

                                    // 3. Lặp qua danh sách sản phẩm
                                    products.forEach(product => {
                                        // product giờ là một đối tượng JSON: {id: 1, tensp: "...", hinhanh: "...", gia: 1890000}

                                        // 4. Tạo HTML phức tạp cho mỗi sản phẩm
                                        html += `
                                <a href="product-detail?id=${product.id}" class="suggestion-item">
                                    <img src="${product.hinhanh}" alt="">
                                    <div class="suggestion-item-info">
                                        <span>${product.tensp}</span>
                                        <span class="suggestion-price">${formatter.format(product.dongia)}</span>
                                    </div>
                                </a>
                            `;
                                    });

                                    suggestionBox.innerHTML = html;
                                    suggestionBox.style.display = 'block';
                                } else {
                                    suggestionBox.style.display = 'none';
                                }
                            })
                            .catch(error => {
                                console.error('Lỗi khi lấy gợi ý:', error);
                                suggestionBox.style.display = 'none';
                            });
                });

               //  5. Ẩn gợi ý khi nhấp ra ngoài
               //  (Chúng ta không cần listener để điền text nữa, vì người dùng sẽ nhấp thẳng vào link)
                document.addEventListener('click', function (e) {
                    if (e.target.id !== 'search-input') {
                        suggestionBox.style.display = 'none';
                    }
                });
            });

