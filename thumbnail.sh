directory=./images
for image in $directory/*
do
cp $image $image.'_th'
constantH=400 
constantW=400
convert $image.'_th' -fuzz 10% -trim $image.'_th'
size=$(identify -format %wx%h $image.'_th')
IFS='x' read -ra sizeArr <<< "$size"
w=${sizeArr[0]}
h=${sizeArr[1]}
echo $w
echo $h
if [ ${w} -gt ${constantW} ] && [ ${h} -gt ${constantH} ]
then
	echo 'resizing bothsides'
	convert $image.'_th' -gravity Center -crop 400x400+0+0 $image.'_th'
elif [ ${w} -gt ${constantW} ]
then
	echo 'resizing extrawidth'
	convert $image.'_th' -gravity Center -crop 400x${h}+0+0 $image.'_th'
elif [ ${h} -gt ${constantH} ]
then
	echo 'resizing extraheight'.$extra
	convert $image.'_th' -gravity Center -crop ${w}x400+0+0 $image.'_th'
fi
size=$(identify -format %wx%h $image.'_th')
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
	convert $image.'_th' -bordercolor Black -border ${extra}x0 $image.'_th'
fi

if [ ${h} -lt ${constantH} ];
then
	extra=`expr $constantH - $h`
	extra=$((extra/2))
	echo 'adding extraheight'.$extra
	convert $image.'_th' -bordercolor Black -border 0x${extra} $image.'_th'
fi
done
