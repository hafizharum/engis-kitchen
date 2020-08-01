unit f1;

interface

	uses typetubes2018;
	
	procedure load (var arrMentah : tabMentah; var arrOlahan : tabOlahan; var arrInvMentah: inventoriMentah; var arrInvOlahan: inventoriOlahan;
					var arrResep: inventoriResep; var arrSimulasi: inventoriSimulasi);
	{I.S. mengakses data dari file eksternal
	 F.S. memasukkan data dari file eksternal ke array yang sesuai}
	 
implementation
	
	uses sysutils;
	
	procedure load (var arrMentah : tabMentah; var arrOlahan : tabOlahan; var arrInvMentah: inventoriMentah; var arrInvOlahan: inventoriOlahan;
					var arrResep: inventoriResep; var arrSimulasi: inventoriSimulasi);
	
	var
		inf 		: text;
		kata		: string;
		i			: integer;
		j 			: integer;
		jumlahLoad	: integer;
		k 			: integer;
	
	begin
		jumlahLoad := 6;
		writeln('> Jumlah file yang harus diload : ', jumlahLoad); 
		
		repeat
			
			case jumlahLoad of
				1						: begin
											writeln(' Nama file: FileBahanMentah.txt'); 
											assign(inf, 'FileBahanMentah.txt');
											reset(inf);
											
											
											jumlahLoad := jumlahLoad - 1;
											
											if EOF(inf) then
											begin
												writeln(' File Kosong');
											end else
											begin
												i := 1;
												
												while (not(EOF(inf))) do
												begin
													readln(inf, kata);
													j := 1;
													
													while ((kata[j] + kata[j+1] + kata[j+2]) <> ' | ') do
													begin
														arrMentah.arrBahanMentah[i].nama := arrMentah.arrBahanMentah[i].nama + kata[j];
														j := j + 1;
													end;
				
													j := j + 3;
				
													while ((kata[j] + kata[j+1] + kata[j+2]) <> ' | ') do
													begin
														arrMentah.arrBahanMentah[i].hargaBeli := arrMentah.arrBahanMentah[i].hargaBeli*10 + StrToInt(kata[j]);
														j := j + 1;
													end;
				
													j := j + 3;
				
													while ((kata[j]) <> ' ') do
													begin
														arrMentah.arrBahanMentah[i].kadaluarsa := arrMentah.arrBahanMentah[i].kadaluarsa*10 + StrToInt(kata[j]);
														j := j + 1;
													end;
													
													arrMentah.neffMentah := i;
													i := i + 1;
												end;
												writeln(' Pembacaan file berhasil');
											end;
											close(inf);
										end;
				
				2						: begin
											writeln(' Nama file: FileBahanOlahan.txt');
											assign(inf, 'FileBahanOlahan.txt');
											reset(inf);
											
											jumlahLoad := jumlahLoad - 1;
											
											if EOF(inf) then
											begin
												writeln(' File Kosong');
											end else
											begin
												i := 1;
												
												while (not(EOF(inf))) do
												begin
													readln(inf, kata);
													j := 1;
													
													while ((kata[j] + kata[j+1] + kata[j+2]) <> ' | ') do
													begin
														arrOlahan.arrBahanOlahan[i].nama := arrOlahan.arrBahanOlahan[i].nama + kata[j];
														j := j + 1;
													end;
				
													j := j + 3;
				
													while ((kata[j] + kata[j+1] + kata[j+2]) <> ' | ') do
													begin
														arrOlahan.arrBahanOlahan[i].hargaJual := arrOlahan.arrBahanOlahan[i].hargaJual*10 + StrToInt(kata[j]);
														j := j + 1;
													end;
				
													j := j + 3;
													
													while ((kata[j] + kata[j+1] + kata[j+2]) <> ' | ') do
													begin
														arrOlahan.arrBahanOlahan[i].jumlahBahan := arrOlahan.arrBahanOlahan[i].jumlahBahan*10 + StrToInt(kata[j]);
														j := j + 1;
													end;
				
													j := j + 3;
													
													for k := 1 to arrOlahan.arrBahanOlahan[i].jumlahBahan do
													begin
														if (k <> arrOlahan.arrBahanOlahan[i].jumlahBahan) then
														begin
															while ((kata[j] + kata[j+1] + kata[j+2]) <> ' | ') do
															begin
																arrOlahan.arrBahanOlahan[i].bahanPembuat[k] := arrOlahan.arrBahanOlahan[i].bahanPembuat[k] + kata[j];
																j := j + 1;
															end;
														end else
														begin
															while ((kata[j]) <> ' ') do
															begin
																arrOlahan.arrBahanOlahan[i].bahanPembuat[k] := arrOlahan.arrBahanOlahan[i].bahanPembuat[k] + kata[j];
																j := j + 1;
															end;
														end;
												
														j := j + 3;
													end;
													
													arrOlahan.neffOlahan := i;
													i := i + 1;
												end;
												writeln(' Pembacaan file berhasil');
											end;
											close(inf);
										end;
										
				3						: begin
											writeln(' Nama file: FileInvMentah.txt');
											assign(inf, 'FileInvMentah.txt');
											reset(inf);
											
											jumlahLoad := jumlahLoad - 1;
											
											if EOF(inf) then
											begin
												writeln(' File Kosong');
											end else
											begin
												i := 1;
												
												while (not(EOF(inf))) do
												begin
													readln(inf, kata);
													j := 1;
													
													while ((kata[j] + kata[j+1] + kata[j+2]) <> ' | ') do
													begin
														arrInvMentah.arrayMentah[i].nama := arrInvMentah.arrayMentah[i].nama + kata[j];
														j := j + 1;
													end;
				
													j := j + 3;
				
													while ((kata[j] + kata[j+1] + kata[j+2]) <> ' | ') do
													begin
														k := j;
														
														while (kata[k] <> '/') do
														begin
															arrInvMentah.arrayMentah[i].tglBeli.hari := arrInvMentah.arrayMentah[i].tglBeli.hari*10 + StrToInt(kata[k]);
															
															k := k + 1;
														end;
														
														k := k + 1;
														
														while (kata[k] <> '/') do
														begin
															arrInvMentah.arrayMentah[i].tglBeli.bulan := arrInvMentah.arrayMentah[i].tglBeli.bulan*10 + StrToInt(kata[k]);
															
															k := k + 1;
														end;
														
														k := k + 1;
														
														while (kata[k] <> ' ') do
														begin
															arrInvMentah.arrayMentah[i].tglBeli.tahun := arrInvMentah.arrayMentah[i].tglBeli.tahun*10 + StrToInt(kata[k]);
															
															k := k + 1;
														end;
														
														j := k;
													end;
													
													j := k + 3;
													
													while ((kata[j] + kata[j+1] + kata[j+2]) <> ' | ') do
													begin
														k := j;
														
														while (kata[k] <> '/') do
														begin
															arrInvMentah.arrayMentah[i].tglKdlMentah.hari := arrInvMentah.arrayMentah[i].tglKdlMentah.hari*10 + StrToInt(kata[k]);
															
															k := k + 1;
														end;
														
														k := k + 1;
														
														while (kata[k] <> '/') do
														begin
															arrInvMentah.arrayMentah[i].tglKdlMentah.bulan := arrInvMentah.arrayMentah[i].tglKdlMentah.bulan*10 + StrToInt(kata[k]);
															
															k := k + 1;
														end;
														
														k := k + 1;
														
														while (kata[k] <> ' ') do
														begin
															arrInvMentah.arrayMentah[i].tglKdlMentah.tahun := arrInvMentah.arrayMentah[i].tglKdlMentah.tahun*10 + StrToInt(kata[k]);
															
															k := k + 1;
														end;
													j := k;
													end;
													
													j := k + 3;
													
													while ((kata[j]) <> ' ') do
													begin
														arrInvMentah.arrayMentah[i].jumlah := arrInvMentah.arrayMentah[i].jumlah*10 + StrToInt(kata[j]);
														j := j + 1;
													end;
													
													arrInvMentah.neffMentah := i;
													i := i + 1;
												end;
												writeln(' Pembacaan file berhasil');
											end;
											close(inf);
										end;
										
				4						: begin
											writeln(' Nama file: FileSimulasi.txt');
											assign(inf, 'FileSimulasi.txt');
											reset(inf);
											
											jumlahLoad := jumlahLoad - 1;
											
											if EOF(inf) then
											begin
												writeln(' File Kosong');
											end else
											begin
												i := 1;
												
												while (not(EOF(inf))) do
												begin
													readln(inf, kata);
													j := 1;
													
													while ((kata[j] + kata[j+1] + kata[j+2]) <> ' | ') do
													begin
														arrSimulasi.arraySimulasi[i].nomor := arrSimulasi.arraySimulasi[i].nomor*10 + StrToInt(kata[j]);
														j := j + 1;
													end;
													
													j := j + 3;
													
													while ((kata[j] + kata[j+1] + kata[j+2]) <> ' | ') do
													begin
														k := j;
														
														while (kata[k] <> '/') do
														begin
															arrSimulasi.arraySimulasi[i].tanggalSimulasi.hari := arrSimulasi.arraySimulasi[i].tanggalSimulasi.hari*10 + StrToInt(kata[k]);
															
															k := k + 1;
														end;
														
														k := k + 1;
														
														while (kata[k] <> '/') do
														begin
															arrSimulasi.arraySimulasi[i].tanggalSimulasi.bulan := arrSimulasi.arraySimulasi[i].tanggalSimulasi.bulan*10 + StrToInt(kata[k]);
															
															k := k + 1;
														end;
														
														k := k + 1;
														
														while (kata[k] <> ' ') do
														begin
															arrSimulasi.arraySimulasi[i].tanggalSimulasi.tahun := arrSimulasi.arraySimulasi[i].tanggalSimulasi.tahun*10 + StrToInt(kata[k]);
															
															k := k + 1;
														end;
														
														j := k;
														
													end;
													
													j := k + 3;
													
													while ((kata[j] + kata[j+1] + kata[j+2]) <> ' | ') do
													begin
														arrSimulasi.arraySimulasi[i].jumlahHari := arrSimulasi.arraySimulasi[i].jumlahHari*10 + StrToInt(kata[j]);
														j := j + 1;
													end;
													
													j := j + 3;
													
													while ((kata[j] + kata[j+1] + kata[j+2]) <> ' | ') do
													begin
														arrSimulasi.arraySimulasi[i].jumlahEnergi := arrSimulasi.arraySimulasi[i].jumlahEnergi*10 + StrToInt(kata[j]);
														j := j + 1;
													end;
													
													j := j + 3;
													
													while ((kata[j] + kata[j+1] + kata[j+2]) <> ' | ') do
													begin
														arrSimulasi.arraySimulasi[i].maksInvMentah := arrSimulasi.arraySimulasi[i].maksInvMentah*10 + StrToInt(kata[j]);
														j := j + 1;
													end;
													
													j := j + 3;
													
													while ((kata[j] + kata[j+1] + kata[j+2]) <> ' | ') do
													begin
														arrSimulasi.arraySimulasi[i].maksInvOlahan := arrSimulasi.arraySimulasi[i].maksInvOlahan*10 + StrToInt(kata[j]);
														j := j + 1;
													end;
													
													j := j + 3;
													
													while ((kata[j] + kata[j+1] + kata[j+2]) <> ' | ') do
													begin
														arrSimulasi.arraySimulasi[i].totalMentahDibeli := arrSimulasi.arraySimulasi[i].totalMentahDibeli*10 + StrToInt(kata[j]);
														j := j + 1;
													end;
													
													j := j + 3;
													
													while ((kata[j] + kata[j+1] + kata[j+2]) <> ' | ') do
													begin
														arrSimulasi.arraySimulasi[i].totalOlahanDibuat := arrSimulasi.arraySimulasi[i].totalOlahanDibuat*10 + StrToInt(kata[j]);
														j := j + 1;
													end;
													
													j := j + 3;
													
													while ((kata[j] + kata[j+1] + kata[j+2]) <> ' | ') do
													begin
														arrSimulasi.arraySimulasi[i].totalOlahanDijual := arrSimulasi.arraySimulasi[i].totalOlahanDijual*10 + StrToInt(kata[j]);
														j := j + 1;
													end;
													
													j := j + 3;
													
													while ((kata[j] + kata[j+1] + kata[j+2]) <> ' | ') do
													begin
														arrSimulasi.arraySimulasi[i].totalResepDijual := arrSimulasi.arraySimulasi[i].totalResepDijual*10 + StrToInt(kata[j]);
														j := j + 1;
													end;
													
													j := j + 3;
													
													while ((kata[j] + kata[j+1] + kata[j+2]) <> ' | ') do
													begin
														arrSimulasi.arraySimulasi[i].totalPemasukan := arrSimulasi.arraySimulasi[i].totalPemasukan*10 + StrToInt(kata[j]);
														j := j + 1;
													end;
													
													j := j + 3;
													
													while ((kata[j] + kata[j+1] + kata[j+2]) <> ' | ') do
													begin
														arrSimulasi.arraySimulasi[i].totalPengeluaran := arrSimulasi.arraySimulasi[i].totalPengeluaran*10 + StrToInt(kata[j]);
														j := j + 1;
													end;
													
													j := j + 3;
													
													while ((kata[j]) <> ' ') do
													begin
														arrSimulasi.arraySimulasi[i].totalUang := arrSimulasi.arraySimulasi[i].totalUang*10 + StrToInt(kata[j]);
														j := j + 1;
													end;
													
													
													arrSimulasi.neffSimulasi := i;
													i := i + 1;
												end;
												writeln(' Pembacaan file berhasil');
											end;
											close(inf);
										end;
										
				5						: begin
											writeln(' Nama file: FileResep.txt');
											assign(inf, 'FileResep.txt');
											reset(inf);
											
											jumlahLoad := jumlahLoad - 1;
											
											if EOF(inf) then
											begin
												writeln(' File Kosong');
											end else
											begin
												i := 1;
												
												while (not(EOF(inf))) do
												begin
													readln(inf, kata);
													j := 1;
													
													while ((kata[j] + kata[j+1] + kata[j+2]) <> ' | ') do
													begin
														arrResep.arrayResep[i].nama := arrResep.arrayResep[i].nama + kata[j];
														j := j + 1;
													end;
				
													j := j + 3;
				
													while ((kata[j] + kata[j+1] + kata[j+2]) <> ' | ') do
													begin
														arrResep.arrayResep[i].hargaJual := arrResep.arrayResep[i].hargaJual*10 + StrToInt(kata[j]);
														j := j + 1;
													end;
				
													j := j + 3;
													
													while ((kata[j] + kata[j+1] + kata[j+2]) <> ' | ') do
													begin
														arrResep.arrayResep[i].jumlahBahan := arrResep.arrayResep[i].jumlahBahan*10 + StrToInt(kata[j]);
														j := j + 1;
													end;
				
													j := j + 3;
													
													for k := 1 to arrResep.arrayResep[i].jumlahBahan do
													begin
														if (k <> arrResep.arrayResep[i].jumlahBahan) then
														begin
															while ((kata[j] + kata[j+1] + kata[j+2]) <> ' | ') do
															begin
																arrResep.arrayResep[i].bahanPembuat[k] := arrResep.arrayResep[i].bahanPembuat[k] + kata[j];
																j := j + 1;
															end;
														end else
														begin
															while ((kata[j]) <> ' ') do
															begin
																arrResep.arrayResep[i].bahanPembuat[k] := arrResep.arrayResep[i].bahanPembuat[k] + kata[j];
																j := j + 1;
															end;
														end;
												
														j := j + 3;
													end;
													
													arrResep.neffResep := i; 
													i := i + 1;
												end;
												writeln(' Pembacaan file berhasil');
											end;
											close(inf);
										end;
										
				6						: begin
											writeln(' Nama file: FileInvOlahan.txt');
											assign(inf, 'FileInvOlahan.txt');
											reset(inf);
											
											jumlahLoad := jumlahLoad - 1;
											
											if EOF(inf) then
											begin
												writeln(' File Kosong');
											end else
											begin
												i := 1;
												
												while (not(EOF(inf))) do
												begin
													readln(inf, kata);
													j := 1;
													
													while ((kata[j] + kata[j+1] + kata[j+2]) <> ' | ') do
													begin
														arrInvOlahan.arrayOlahan[i].nama := arrInvOlahan.arrayOlahan[i].nama + kata[j];
														j := j + 1;
													end;
				
													j := j + 3;
				
													while ((kata[j] + kata[j+1] + kata[j+2]) <> ' | ') do
													begin
														k := j;
														
														while (kata[k] <> '/') do
														begin
															arrInvOlahan.arrayOlahan[i].tglBuat.hari := arrInvOlahan.arrayOlahan[i].tglBuat.hari*10 + StrToInt(kata[k]);
															
															k := k + 1;
														end;
														
														k := k + 1;
														
														while (kata[k] <> '/') do
														begin
															arrInvOlahan.arrayOlahan[i].tglBuat.bulan := arrInvOlahan.arrayOlahan[i].tglBuat.bulan*10 + StrToInt(kata[k]);
															
															k := k + 1;
														end;
											
														
														k := k + 1;
														
														while (kata[k] <> ' ') do
														begin
															arrInvOlahan.arrayOlahan[i].tglBuat.tahun := arrInvOlahan.arrayOlahan[i].tglBuat.tahun*10 + StrToInt(kata[k]);
															
															k := k + 1;
														end;
														
														j := k;
													end;
													
													j := k + 3;
													
													while ((kata[j] + kata[j+1] + kata[j+2]) <> ' | ') do
													begin
														k := j;
														
														while (kata[k] <> '/') do
														begin
															arrInvOlahan.arrayOlahan[i].tglKdlOlahan.hari := arrInvOlahan.arrayOlahan[i].tglKdlOlahan.hari*10 + StrToInt(kata[k]);
															
															k := k + 1;
														end;
														
														k := k + 1;
														
														while (kata[k] <> '/') do
														begin
															arrInvOlahan.arrayOlahan[i].tglKdlOlahan.bulan := arrInvOlahan.arrayOlahan[i].tglKdlOlahan.bulan*10 + StrToInt(kata[k]);
															
															k := k + 1;
														end;
														
														k := k + 1;
														
														while (kata[k] <> ' ') do
														begin
															arrInvOlahan.arrayOlahan[i].tglKdlOlahan.tahun := arrInvOlahan.arrayOlahan[i].tglKdlOlahan.tahun*10 + StrToInt(kata[k]);
															
															k := k + 1;
														end;
														   
													j := k;
													end;
													
													
													j := k + 3;

													while ((kata[j] + kata[j+1] + kata[j+2]) <> ' | ') do
													begin
														
														arrInvOlahan.arrayOlahan[i].hargaJual := arrInvOlahan.arrayOlahan[i].hargaJual*10 + StrToInt(kata[j]);
															
														j := j + 1;
														   
													end;
													
													
													j := j + 3;
													
													while ((kata[j]) <> ' ') do
													begin
														arrInvOlahan.arrayOlahan[i].jumlah := arrInvOlahan.arrayOlahan[i].jumlah*10 + StrToInt(kata[j]);
														j := j + 1;
													end;
													
													arrInvOlahan.neffOlahan := i;
													i := i + 1;
												end;
												writeln(' Pembacaan file berhasil');
											end;
											close(inf);
										end;
										
				
				
											
			end;
		until (jumlahLoad = 0);
		
		if (jumlahLoad=0) then
		begin
			writeln(' Semua File Telah Terbaca')
		end;
	end;
end.
		
	