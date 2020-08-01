unit f10;

interface

	uses typetubes2018;
	
	procedure istirahat(var jEnergi: integer; var countIstirahat : integer; var sudahTidur: boolean; var isSimulasi: boolean);
	{I.S. mengakses data pada array simulasi
	 F.S. menambahkan jumlah energi sebanyak 1 buah pada data array simulasi}
	 
implementation
	// Fungsi Istirahat
	procedure istirahat(var jEnergi: integer; var countIstirahat : integer; var sudahTidur: boolean; var isSimulasi: boolean);
	
	var
		total : integer;
		
	begin
		if (isSimulasi = true) then // jika berada dalam simulasi
		begin
		
			if countIstirahat < 6 then 
			begin
				total := jEnergi + 1;
			
				if (total > 10) then total := 10; // maksimum energi sebanyak 10 buah
		
				jEnergi := total;
				countIstirahat := countIstirahat + 1;
				sudahTidur := false;
				
				writeln('Istirahat sudah selesai!');
				writeln('Energimu sekarang ', jEnergi);
			end else // jika istirahat sudah berlangsung lebih dari 6 kali sehari
			begin
				writeln('Kebanyakan Istirahat !!');
			end;
		end else
		begin // jika belum berada dalam simulasi
			writeln('Simulasi belum dimulai. Mulai simulasi untuk masuk ke aksi ini.');
		end;
	end;
end.