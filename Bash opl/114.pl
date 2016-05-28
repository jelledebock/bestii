#!/usr/bin/perl

open($file, "<","dhcp.log") or die "Could not open test.log $!";

 
while ($row = <$file>){
	chomp $row;
	if ( $row =~ /^[0-9]{2}\+?[^,]/) {
		($id,$meaning)=split(/	/,$row);
		$ids{$id} = $meaning;
	}
	else {
		if ( $row =~ /^[0-9]+,/ ){
			($id,$date,$time,$desc,$ip,$hostname,$mac,$user,$transid,$qresult,$probtime,$corrid)=split(/,/,$row);
			unless ($info{$id}){
				#print "$id\n";
				$info{$id}=[];
			}
			my %rec=(
				id => $id,
				date => $date,
				time => $time,
				desc => $desc,
				ip => $ip,
				hostname => $hostname,
				mac => $mac,
				user => $user,
				transid => $transid,
				qresult => $qresult,
				probtime => $probtime,
				corrid => $corrid
			);
			#print ${\%rec}{ip};		
			push(@{$info{$id}},\%rec);
		}	
	}
}
print "Toestellen die een lease hebben verkregen:\n";
for $i (values @{%info{10}}){	
	my %rec=%{$i};
	print "$rec{date} $rec{hostname} $rec{mac}\n";
}

print "Aantal toestellen dat een IP-adres hebben gevraagd maar niet hebben gekregen: ";
my $size= @{%{info{15}}}; 
print "$size\n";

my %temp;

print "Toestellen die 's nachts zijn blijven aanstaan:\n";
for $i (values @{%info{11}}) {
	my %rec= %{$i};
	unless ( $temp{$rec{date}} ) {
		$temp{$rec{date}}=[];
	}
	push (@{$temp{$rec{date}}},$rec{hostname}) if ( $rec{time} =~ /^[0][0-6]/ );
}

for $i (keys %temp){
	print "$i: ".join(", ",@{$temp{$i}})."\n";
}
