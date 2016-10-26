#!/usr/local/bin/perl
# Mike McQuade
# DeBruijn-Integer-String.pl
# Constructs a DeBruijn Graph for a given integer
# and a given string.

# Define the packages to use
use strict;
use warnings;

# Initialize variables
my ($k,$text,%deBruijn);

# Open the file to read
open(my $fh,"<ba3d.txt") or die $!;

# Read in the values from the file
$k = <$fh>;
chomp($k);
$text = <$fh>;
chomp($text);

# Map each k-mer with a matching suffix to a k-mer with a matching prefix
for (my $i = 1; $i <= length($text) - ($k-1); $i++) {
	if (!$deBruijn{substr($text, $i-1, $k-1)}) {
		$deBruijn{substr($text, $i-1, $k-1)} = [substr($text, $i, $k-1)];
	} else {
		push ($deBruijn{substr($text, $i-1, $k-1)}, substr($text, $i, $k-1));
	}
}

# Print out the graph
foreach my $key (sort keys %deBruijn) {
	print "$key -> ";
	print join(",", sort @{$deBruijn{$key}});
	print "\n";
}

# Close the file
close($fh) || die "Couldn't close file properly";