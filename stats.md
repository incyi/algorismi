---
layout: default
title: stats
---

<a href="index">Home</a> -
<a href="legend">The Legend</a> -
<a href="laboratorium">Lab</a> -
<a href="about">About</a> -
<a href="contact">Contact</a>

# Some statistucs and weird stuff ⚡️

Your IP address is: <span id="user-ip">Loading...</span>

// Fetch IP address
fetch('https://ipify.org')
  .then(response => response.json())
  .then(data => {
    // Insert the IP into an HTML element with id="user-ip"
    document.getElementById('user-ip').textContent = data.ip;
  })
  .catch(error => {
    console.error('Error fetching IP:', error);
    document.getElementById('user-ip').textContent = "Unable to load IP";
  });
  
