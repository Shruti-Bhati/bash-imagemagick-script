directory=./images
for image in $directory/*
do
constantH=1136 
constantW=640
convert $image -fuzz 10% -trim $image
size=$(identify -format %wx%h $image)
IFS='x' read -ra sizeArr <<< "$size"
w=${sizeArr[0]}
h=${sizeArr[1]}
echo $w
echo $h
if [ ${w} -gt ${constantW} ] && [ ${h} -gt ${constantH} ]
then
	echo 'resizing bothsides'
	convert $image -resize 640x1136 $image
elif [ ${w} -gt ${constantW} ]
then
	echo 'resizing extrawidth'
	convert $image -resize 640x${h} $image
elif [ ${h} -gt ${constantH} ]
then
	echo 'resizing extraheight'.$extra
	convert $image -resize ${w}x1136 $image
fi
size=$(identify -format %wx%h $image)
IFS='x' read -ra sizeArr <<< "$size"
w=${sizeArr[0]}
h=${sizeArr[1]}
echo $w
echo $h
if [ ${w} -lt ${constantW} ]
then
	extra=`expr $constantW - $w`
	extra=$((extra/2))
	echo 'adding extrasides'.$extra
	convert $image -bordercolor Black -border ${extra}x0 $image
fi

if [ ${h} -lt ${constantH} ];
then
	extra=`expr $constantH - $h`
	extra=$((extra/2))
	echo 'adding extraheight'.$extra
	convert $image -bordercolor Black -border 0x${extra} $image
fi
done
