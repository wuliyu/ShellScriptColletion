#! /bin/bash
urls=$(cat list.txt)
for url in ${urls[@]};do
	{
		you-get $url
	}&
done
