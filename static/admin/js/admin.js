$(document).ready(function () {
    // 侧边栏切换
    $('#sidebarCollapse').on('click', function () {
        $('#sidebar').toggleClass('active');
    });

    // 下拉菜单
    $('.dropdown-toggle').dropdown();

    // 自动关闭警告消息
    $('.alert').alert();
    setTimeout(function() {
        $('.alert').alert('close');
    }, 3000);

    // 激活工具提示
    $('[data-bs-toggle="tooltip"]').tooltip();

    // 激活弹出框
    $('[data-bs-toggle="popover"]').popover();

    // 激活当前菜单项
    const currentPath = window.location.pathname;
    $('.sidebar ul li a').each(function() {
        if ($(this).attr('href') === currentPath) {
            $(this).parent().addClass('active');
            $(this).parents('.collapse').addClass('show');
            $(this).parents('li').addClass('active');
        }
    });

    // 表格全选功能
    $('.select-all').on('click', function() {
        const checked = $(this).prop('checked');
        $('.select-item').prop('checked', checked);
        updateBulkActionButtons();
    });

    $('.select-item').on('click', function() {
        updateBulkActionButtons();
    });

    // 更新批量操作按钮状态
    function updateBulkActionButtons() {
        const selectedCount = $('.select-item:checked').length;
        $('.bulk-action-btn').prop('disabled', selectedCount === 0);
        $('.selected-count').text(selectedCount);
    }

    // 确认删除对话框
    $('.delete-confirm').on('click', function(e) {
        e.preventDefault();
        const url = $(this).attr('href');
        if (confirm('确定要删除这条记录吗？此操作不可恢复！')) {
            window.location.href = url;
        }
    });

    // AJAX表单提交
    $('.ajax-form').on('submit', function(e) {
        e.preventDefault();
        const form = $(this);
        const submitBtn = form.find('[type="submit"]');
        const originalText = submitBtn.text();
        
        submitBtn.prop('disabled', true).text('提交中...');
        
        $.ajax({
            url: form.attr('action'),
            type: form.attr('method'),
            data: form.serialize(),
            success: function(response) {
                if (response.status === 'success') {
                    showAlert('success', response.message);
                    if (response.redirect) {
                        setTimeout(function() {
                            window.location.href = response.redirect;
                        }, 1500);
                    }
                } else {
                    showAlert('danger', response.message);
                }
            },
            error: function(xhr) {
                showAlert('danger', '操作失败，请稍后重试');
            },
            complete: function() {
                submitBtn.prop('disabled', false).text(originalText);
            }
        });
    });

    // 显示提示信息
    function showAlert(type, message) {
        const alert = $('<div class="alert alert-' + type + ' alert-dismissible fade show" role="alert">' +
            message +
            '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>' +
            '</div>');
        
        $('.container-fluid').prepend(alert);
        
        setTimeout(function() {
            alert.alert('close');
        }, 3000);
    }

    // 图表初始化（如果页面中有图表）
    if ($('#visitsChart').length) {
        const ctx = document.getElementById('visitsChart').getContext('2d');
        new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['1月', '2月', '3月', '4月', '5月', '6月'],
                datasets: [{
                    label: '访问量',
                    data: [65, 59, 80, 81, 56, 55],
                    borderColor: '#4e73df',
                    tension: 0.1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false
            }
        });
    }

    // 文件上传预览
    $('.custom-file-input').on('change', function() {
        const fileName = $(this).val().split('\\').pop();
        $(this).next('.custom-file-label').html(fileName);
        
        if (this.files && this.files[0]) {
            const reader = new FileReader();
            reader.onload = function(e) {
                $('#imagePreview').attr('src', e.target.result);
            }
            reader.readAsDataURL(this.files[0]);
        }
    });

    // 搜索框自动完成
    $('.search-input').on('keyup', function() {
        const query = $(this).val();
        if (query.length > 2) {
            $.get('/admin/search/', { q: query }, function(data) {
                const results = data.results;
                const dropdown = $('.search-results');
                dropdown.empty();
                
                results.forEach(function(result) {
                    dropdown.append(
                        $('<a class="dropdown-item" href="' + result.url + '">' +
                            result.title +
                        '</a>')
                    );
                });
                
                dropdown.show();
            });
        }
    });

    // 日期选择器初始化
    $('.datepicker').datepicker({
        format: 'yyyy-mm-dd',
        autoclose: true,
        language: 'zh-CN'
    });

    // 富文本编辑器初始化
    if ($('#editor').length) {
        ClassicEditor
            .create(document.querySelector('#editor'))
            .catch(error => {
                console.error(error);
            });
    }
}); 