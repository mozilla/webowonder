UPDATE demos_submission SET hidden = b'1' WHERE slug IN ("AR_photobooth", "plztouchme");

UPDATE demos_submission SET hidden = b'0', title = "No Comply", description = "Animate the soul of your songs using WebGL and AudioAPI technology. Bring your audio and visual elements together in harmony!", slug = "nocomply" WHERE slug = "dj_kraddy";
