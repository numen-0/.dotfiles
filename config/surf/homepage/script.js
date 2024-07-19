
function updateTime() {
    const now = new Date();
    const hours = String(now.getHours()).padStart(2, '0');
    const minutes = String(now.getMinutes()).padStart(2, '0');
    const seconds = String(now.getSeconds()).padStart(2, '0');
    const currentTime = `${hours}:${minutes}:${seconds}`;

    document.getElementById('clock').textContent = currentTime;
}

function performSearch() {
    var query = document.getElementById('searchInput').value.trim();

    if ( query ) {
        var url = 'https://duckduckgo.com/?q=' + encodeURIComponent(query);
        window.location.href = url;
    }

    document.getElementById('searchInput').value = '';
}

//---------------------------------------------------------------------------//

setInterval(updateTime, 1000);
updateTime();

document.getElementById('searchInput').addEventListener('keydown', function(event) {
    console.log("catch");
    if ( event.key === 'Enter' ) {
        console.log("ENTER!!!");
        performSearch();
    }
});

document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('searchInput').focus();
});

