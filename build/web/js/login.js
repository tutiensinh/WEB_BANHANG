/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

document.addEventListener('DOMContentLoaded', function () {
    const togglePassword = document.querySelector('#togglePassword');
    const password = document.querySelector('#matkhau');
    const icon = togglePassword.querySelector('i');

    togglePassword.addEventListener('click', function (e) {
        // Lấy type hiện tại của input
        const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
        password.setAttribute('type', type);

        // Đổi icon
        if (type === 'password') {
            icon.classList.remove('bi-eye-slash-fill');
            icon.classList.add('bi-eye-fill');
        } else {
            icon.classList.remove('bi-eye-fill');
            icon.classList.add('bi-eye-slash-fill');
        }
    });
});

