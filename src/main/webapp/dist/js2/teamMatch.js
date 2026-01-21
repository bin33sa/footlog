$(function() {
    listPage(1);
});

function listPage(page) {
    if (!page) page = 1;

    let url = contextPath + '/myteam/match_list';
    
    let query = { 
        teamCode: currentTeamCode, 
        page: page, 
        size: 10 
    };

    ajaxRequest(url, 'get', query, 'json', function(data) {
        
        const container = document.querySelector('#match-list-container');
        const pagingContainer = document.querySelector('#list-page');
        const template = document.querySelector('#match-template');

        container.innerHTML = '';
        pagingContainer.innerHTML = '';

        if (data.state === "true" && data.list && data.list.length > 0) {
            
            data.list.forEach(dto => {
                let clone = template.content.cloneNode(true);
                
                clone.querySelector('.match-month').textContent = dto.match_month + '월';
                clone.querySelector('.match-day').textContent = dto.match_day;
                clone.querySelector('.match-time').textContent = dto.match_time;
                clone.querySelector('.opponent-name').textContent = dto.opponent_name || '미정';
                clone.querySelector('.stadium-name').textContent = dto.stadiumName ? dto.stadiumName : '장소 미정';

                let badgeArea = clone.querySelector('.status-badge-area');
                let btnArea = clone.querySelector('.btn-area');
                let progressArea = clone.querySelector('.progress-area');

                badgeArea.textContent = dto.status;
                badgeArea.className = 'status-badge-area badge'; 
                
                if (dto.status === '모집중') {
                    badgeArea.classList.add('bg-primary', 'text-white');
                } else if (dto.status === '매칭완료' || dto.status === '모집완료') {
                    badgeArea.classList.add('bg-success', 'text-white');
                } else {
                    badgeArea.classList.add('bg-light', 'text-secondary', 'border');
                }

                if (dto.status === '모집중' || dto.status === '매칭완료') {
                    let attend = dto.attend_count || 0;
                    
                    let targetCount = 11;
                    if(dto.matchType) {
                        let numbers = dto.matchType.match(/\d+/);
                        if(numbers) {
                            targetCount = parseInt(numbers[0]);
                        }
                    }

                    let percent = Math.round((attend / targetCount) * 100);
                    if(percent > 100) percent = 100;

                    progressArea.style.display = 'block';
                    clone.querySelector('.attendance-bar').style.width = percent + '%';
                    
                    clone.querySelector('.attendance-text').innerHTML = 
                        `<span class="text-success fw-bold">${attend}명</span> / ${targetCount}명 (${percent}%)`;

                    let alertMsg = clone.querySelector('.alert-msg');
                    if (attend < targetCount) {
                        alertMsg.style.display = 'block';
                        clone.querySelector('.alert-msg').innerHTML = 
                            `<i class="bi bi-exclamation-circle"></i> ${targetCount}명까지 <span class="remain-count">${targetCount - attend}</span>명 남음!`;
                    } else {
                        alertMsg.style.display = 'none';
                    }
                } else {
                    progressArea.style.display = 'none';
                }
                let btnHtml = '';
                if (dto.status === '모집중') {
                    btnHtml = `
                        <a href="${contextPath}/myteam/attendance?teamCode=${currentTeamCode}&matchCode=${dto.match_code}" 
                           class="btn btn-outline-primary rounded-pill px-4 py-2 fw-bold hover-filled">
                            투표 하러가기 <i class="bi bi-arrow-right-circle-fill ms-1"></i>
                        </a>`;
                } else if (dto.status === '매칭완료' || dto.status === '모집완료') {
                    btnHtml = `
                        <a href="${contextPath}/myteam/attendance?teamCode=${currentTeamCode}&matchCode=${dto.match_code}" 
                           class="btn btn-dark rounded-pill px-4 py-2 fw-bold">
                            상세 확인 <i class="bi bi-arrow-right-short ms-1"></i>
                        </a>`;
                } else {
                    btnHtml = `
                        <button class="btn btn-outline-secondary rounded-pill px-4 py-2" disabled>
                            대기 중 <i class="bi bi-hourglass ms-1"></i>
                        </button>`;
                }
                btnArea.innerHTML = btnHtml;

                container.appendChild(clone);
            });

            let pagingHtml = pagingMethod(data.page, data.total_page, 'listPage'); 
            pagingContainer.innerHTML = pagingHtml;

        } else {
            container.innerHTML = `
                <div class="col-12 text-center py-5">
                    <div class="text-muted fs-1 mb-3"><i class="bi bi-calendar-x"></i></div>
                    <div class="text-muted fs-5 mb-2">등록된 매치 일정이 없습니다.</div>
                </div>`;
        }
    });
}