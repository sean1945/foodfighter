// 타이틀 부여
function setTitle() {
	const tt = document.getElementsByTagName("title")[0];
	const query = document.location.search.match(/(?<=(q=))[^&]*/)[0];
	tt.innerText = decodeURI(query) + " - 푸드파이터 검색";
	
	window.removeEventListener("load", setTitle);
}

window.addEventListener("load", setTitle);

// 네이버 지도 표시
function setMap(addr) {
	const mapInfo = document.getElementById("map_info");
	
	naver.maps.Service.geocode({
	    query: addr
	}, function(status, response) {
	    if (status !== naver.maps.Service.Status.OK) {
	        return alert('네이버 맵 서비스가 동작되지 않았습니다.');
	    }

	    const result = response.v2; // 검색 결과의 컨테이너
	    const items = result.addresses; // 검색 결과의 배열
	    const position = new naver.maps.LatLng(items[0].y, items[0].x);
	    
	    const mapOptions = {
		    center: position,
		    zoom: 18
		};
		const map = new naver.maps.Map('map', mapOptions);
		const markerOptions = {
			position: position,
			map: map
		}
		const marker = new naver.maps.Marker(markerOptions);
	});
}
// 지도표시버튼에 이벤트 부여
function setMapEvent() {
	const restList = Array.from(document.getElementById("restaurant_list").children);
	
	restList.forEach(function(rest) {
		const addr = rest.getAttribute("data-address");
		const mapButton = rest.getElementsByClassName("map_button")[0];
		mapButton.addEventListener("click", function() {
			setMap(addr);
			const naverMap = document.getElementById("naver_map");
			
			if (rest.contains(naverMap) && naverMap.classList.contains("active")) {
				naverMap.classList.remove("active");
			} else {
				naverMap.classList.add("active");
			}
			rest.appendChild(naverMap);
		});
	});
}

setMapEvent();
