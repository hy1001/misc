#!/usr/local/bin/perl

use strict;
use File::Find::Rule;
use MIME::Lite;

my $three_days_ago = time() - 3 * 86400;
my $three_hours_ago = time() - 3 * 3600;
my $three_min_ago = time() - 3 * 60;

my @files_3HrOld = File::Find::Rule->file()
    ->mtime("<$three_hours_ago") # older than 3 hours
#    ->mtime("<$three_min_ago") # younger than 3 mins
    ->name('QCUpdate.lock') # looking for .lock file
#     ->name('aaa.lock') # looking for .lock file
    ->in("/mnt/wiggum/Applied Research/Data Repository/QC Database Updates");

#print "@files_3HrOld\n";
#print length(@files_3HrOld), "\n";

my $MSG;
my $SUBJ;
#$SUBJ = 'ok';
#$MSG = 'life is good';

foreach (@files_3HrOld) {
    if($_ =~ /lock/) {
	# print "yes\n";
	# print $_, "\n";
	$SUBJ = 'Please check QCUpdate.lock file';
	$MSG = "QCUpdate.lock file is older than 3 hours.\n\nThanks!\n\n- Henry";
	my $msg = MIME::Lite->new(
	    From     => 'hpaik@agamatrix.com',
	    To       => 'agamatrix@s-and-r-williams.com',
#	    To       => 'hpaik@agamatrix.com',
	    Cc       => 'hy1001@yahoo.com',
#	    Subject  => 'Please check .Lock file in wiggum',
	    Subject  => $SUBJ,
#	    Data => 'Message Body here'
	    Data => $MSG
#    Type     => 'image/gif',
#    Encoding => 'base64',
#    Path     => 'hellonurse.gif'
	    );
	$msg->send; # send via default
    } 
}



# print $SUBJ, "\n", $hmm_takeALook;


# my $ten_days_ago = time() - 10 * 86400;
# my @to_delete = File::Find::Rule->file()
#   ->mtime("<=$ten_days_ago")
#   ->in("/mnt/wiggum/Applied Research/Data Repository/QC Database Updates");

# print "@to_delete \n";

#in("/path/to/db_backup");
#unlink @to_delete;
