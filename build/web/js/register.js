/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

document.addEventListener('DOMContentLoaded', function () {
    // Hàm chung để xử lý bật/tắt
    function setupPasswordToggle(inputId, toggleId) {
        const toggle = document.querySelector(toggleId);
        const input = document.querySelector(inputId);
        const icon = toggle.querySelector('i');

        toggle.addEventListener('click', function () {
            const type = input.getAttribute('type') === 'password' ? 'text' : 'password';
            input.setAttribute('type', type);

            if (type === 'password') {
                icon.classList.remove('bi-eye-slash-fill');
                icon.classList.add('bi-eye-fill');
            } else {
                icon.classList.remove('bi-eye-fill');
                icon.classList.add('bi-eye-slash-fill');
            }
        });
    }

    // Áp dụng cho cả 2 ô mật khẩu
    setupPasswordToggle('#matkhau', '#toggleMatKhau');
    setupPasswordToggle('#nhaplaimatkhau', '#toggleNhapLaiMatKhau');
});


