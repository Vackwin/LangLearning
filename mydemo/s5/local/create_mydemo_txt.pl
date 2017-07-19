#!/usr/bin/env perl

$info = $ARGV[0];
$inlist = $ARGV[1];

open IL, $inlist;

while ($l = <IL>)
{
	$uid = substr $l,3,5;
	open IF, $info;
	while ($l2 = <IF>)
	{
		if ($l2 =~ /$uid/)
		{
			my @arr = split('\t',$l2);
			$l2 = $arr[2];
			last;
		}	
	}
	close IF;
	chomp($l);
	chomp($l2);
	$l =~ s/\.wav/ /;
	$l2 =~ s/\_/ /g;
	print "$l $l2\n";
}
close IL;

