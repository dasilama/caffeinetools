# resize usage:
# resize <folder> <image type> <scale>
# IE: resize ./ *.JPG 35



require 'rubygems'
require 'RMagick'

# get the folder containing the original images
folder = "./"

#  and the extension type
extension = "*.png"



if not ARGV[0].nil?
	if File.directory?(ARGV[0])
		folder = ARGV[0]
		if not folder[-1..-1] == "/"
			folder << "/"
		end
	end
	
	if not ARGV[1].nil?
		if !!ARGV[1][/\*\..../] and ARGV[1].length >= 5
			extension = ARGV[1]
		end
	end
end

# reduce by 35% = 35/100
scale_by = 0.75

# get scale size
if ARGV.last[/\d\d/].length == 2 and ARGV.last.length == 2
	scale_by = ARGV.last.to_f/100
end

outfolder = "resized/"
Dir.mkdir(outfolder) unless File.exists?(outfolder)

# Get the images in the folder

Dir.glob("#{folder + extension}") do |f|
 # read the image
 image = Magick::Image.read(f).first

 # scale the images
 puts "Resizing #{image.filename} on a scale of #{(scale_by*100).to_i}% to #{folder + outfolder + image.filename} "
 new_image = image.scale(scale_by)
 new_image.write(outfolder + image.filename)
 
 # IMPORTANT!!! # Free up memory as this image won't be worked on again.
 [image,new_image].each { |img| img.destroy! }
 
end
