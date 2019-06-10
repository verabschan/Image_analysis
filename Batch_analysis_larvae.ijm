

macro "Multiple measurement" {
	G_Sdir = getDirectory("Choose the Directory where the file is");
	G_Ddir = getDirectory("Destination Directory")
	list = getFileList(G_Sdir);
	for(i = 0; i<list.length; i++) {
	NucAnalysis(list[i]);
	}
}

function NucAnalysis(img_filename) {
	fullpath_image = G_Sdir + img_filename;
	open(fullpath_image);
	sourceID = getImageID();
	img_title = getTitle();
	run("Set Scale...", "distance=1.6501 known=1 pixel=1 unit=µm global");
	run("8-bit");
	setMinAndMax(48, 95);
	setThreshold(0, 80);
	run("Convert to Mask");
	run("Fill Holes");
	//run("Analyze Particles...", "size=10-infinity circularity=0.30-1.00 show=Nothing display exclude clear add"); 
	run("Set Measurements...", "area perimeter shape feret's display redirect=None decimal=3");
	run("Analyze Particles...", "size=18-1nfinity show=Outlines display exclude clear");
	saveAs("Jpeg",G_Ddir+list[i]+".jpg");
	selectWindow("Results");
	saveAs("Results",G_Ddir+list[i]+".csv");
	close();
	close();
}