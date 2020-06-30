
function init_map(div_map_container){

	var access_token = "pk.eyJ1IjoicnNjaGlmYW4iLCJhIjoiY2p2anNyZHI4MDhzbjQ5cWl0enB0NmFjbSJ9.TCQ_YUSwqIXEo1f6GdmBZg"
	


	var map = L.map(div_map_container).setView([40.782, -73.971636], 12);
	
	options = {
			maxZoom: 18,
			attribution: 
				'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
				'<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
				'Imagery © <a href="http://mapbox.com">Mapbox</a>',
			id: 'mapbox.dark',
			// id: 'mapbox.satellite',
		};


	L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token='+access_token, options).addTo(map);
	
	return map;
}
