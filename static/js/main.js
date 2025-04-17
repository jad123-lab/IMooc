// 视频播放相关功能
document.addEventListener('DOMContentLoaded', function() {
    const video = document.querySelector('video');
    const progressBar = document.querySelector('.progress-bar');
    
    if (video && progressBar) {
        // 视频播放时更新进度条
        video.addEventListener('timeupdate', function() {
            const progress = (video.currentTime / video.duration) * 100;
            progressBar.style.width = progress + '%';
        });
    }

    // 点赞功能
    const likeBtn = document.querySelector('.like-btn');
    if (likeBtn) {
        likeBtn.addEventListener('click', function(e) {
            e.preventDefault();
            const videoId = this.dataset.videoId;
            fetch(`/videos/${videoId}/like/`, {
                method: 'POST',
                headers: {
                    'X-CSRFToken': getCookie('csrftoken'),
                    'Content-Type': 'application/json',
                },
            })
            .then(response => response.json())
            .then(data => {
                if (data.status === 'success') {
                    const likeCount = document.querySelector('.like-count');
                    likeCount.textContent = data.likes;
                    this.classList.toggle('liked');
                }
            });
        });
    }
});

// 获取Cookie的辅助函数
function getCookie(name) {
    let cookieValue = null;
    if (document.cookie && document.cookie !== '') {
        const cookies = document.cookie.split(';');
        for (let i = 0; i < cookies.length; i++) {
            const cookie = cookies[i].trim();
            if (cookie.substring(0, name.length + 1) === (name + '=')) {
                cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                break;
            }
        }
    }
    return cookieValue;
}

// 评论提交功能
const commentForm = document.querySelector('#comment-form');
if (commentForm) {
    commentForm.addEventListener('submit', function(e) {
        e.preventDefault();
        const videoId = this.dataset.videoId;
        const content = this.querySelector('textarea').value;

        fetch(`/comments/add/${videoId}/`, {
            method: 'POST',
            headers: {
                'X-CSRFToken': getCookie('csrftoken'),
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                content: content
            })
        })
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                // 不刷新页面，而是动态更新评论列表
                const commentsList = document.querySelector('#comments-list');
                if (commentsList) {
                    fetch(`/comments/list/${videoId}/`)
                        .then(response => response.text())
                        .then(html => {
                            commentsList.innerHTML = html;
                            // 清空评论框
                            this.querySelector('textarea').value = '';
                        });
                }
            }
        });
    });
} 