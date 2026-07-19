---
layout: default
title: stats
---

<a href="index">Home</a> -
<a href="legend">The Legend</a> -
<a href="laboratorium">Lab</a> -
<a href="about">About</a> -
<a href="contact">Contact</a>

# Some statistics and weird stuff ⚡️

Your IP address is: <span id="user-ip">Loading...</span>

Your approximate location: <span id="user-location">Loading...</span>

<script>
// Fetch IP address then query ip-api.com for geolocation
function setText(id, text) {
  var el = document.getElementById(id);
  if (el) el.textContent = text;
}

fetch('https://api.ipify.org?format=json')
  .then(response => response.json())
  .then(data => {
    var ip = data.ip;
    setText('user-ip', ip);

    // Try HTTPS first (may fail if ip-api blocks HTTPS on free tier),
    // then fall back to HTTP. Note: if this page is served over HTTPS,
    // browsers will block an HTTP request (mixed content). If that
    // happens, consider using an HTTPS-friendly service (e.g. ipinfo.io,
    // ipapi.co) or a server-side proxy.
    var triedHttpFallback = false;
    function fetchLocation(url) {
      return fetch(url)
        .then(resp => resp.json())
        .then(loc => {
          if (loc && loc.status === 'success') {
            var pretty = `${loc.city || ''}${loc.city ? ', ' : ''}${loc.regionName || ''}${(loc.city || loc.regionName) ? ', ' : ''}${loc.country || ''} (lat: ${loc.lat}, lon: ${loc.lon}) — ${loc.isp || ''}`;
            setText('user-location', pretty);
          } else {
            throw new Error('Location lookup failed');
          }
        });
    }

    // ip-api.com endpoint (user asked for ip-api.com specifically)
    var httpsUrl = 'https://ip-api.com/json/' + encodeURIComponent(ip) + '?fields=status,country,regionName,city,lat,lon,isp,query';
    var httpUrl = 'http://ip-api.com/json/' + encodeURIComponent(ip) + '?fields=status,country,regionName,city,lat,lon,isp,query';

    fetchLocation(httpsUrl).catch(error => {
      console.warn('HTTPS lookup failed, trying HTTP (may be blocked by browser):', error);
      // Try HTTP fallback once
      if (!triedHttpFallback) {
        triedHttpFallback = true;
        fetchLocation(httpUrl).catch(err2 => {
          console.error('HTTP lookup also failed:', err2);
          setText('user-location', 'Unable to determine location via ip-api.com.');
        });
      }
    });

  })
  .catch(error => {
    console.error('Error fetching IP:', error);
    setText('user-ip', 'Unable to load IP');
    setText('user-location', 'Unable to determine location');
  });
</script>
