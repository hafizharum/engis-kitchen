unit f2;

interface

	uses typetubes2018;
	
	procedure exit (var arrMentah : tabMentah; var arrOlahan : tabOlahan; var arrInvMentah: inventoriMentah; var arrInvOlahan: inventoriOlahan;
					var arrResep: inventoriResep; var arrSimulasi: inventoriSimulasi);
	{I.S. mengakses array yang digunakan selama simulasi
	 F.S. menyimpan data dari array ke file eksternal yang sesuai}
	 
implementation
	
	uses sysutils;
	
	procedure exit (var arrMentah : tabMentah; var arrOlahan : tabOlahan; var arrInvMentah: inventoriMentah; var arrInvOlahan: inventoriOlahan;
					var arrResep: inventoriResep; var arrSimulasi: inventoriSimulasi);
	
	var
		inf 		: text;
		kata		: string;
		i			: integer;
		j 			: integer;
		k 			: integer;
		temp		: string;

	begin
		for i:=1 to 6 do
		begin
			case i of
				1	:	begin
							assign(inf,'FileBahanMentah.txt');
							rewrite(inf);
							
							for j:=1 to arrMentah.neffMentah do
								begin
									kata := arrMentah.arrBahanMentah[j].nama + ' | ' + IntToStr(arrMentah.arrBahanMentah[j].hargaBeli) + ' | ' 
											+ IntToStr(arrMentah.arrBahanMentah[i].kadaluarsa) + ' ';
									writeln(inf, kata);
								end;
								
							close(inf);
						end;
					
				2	:	begin
							assign(inf,'FileBahanOlahan.txt');
							rewrite(inf);
						
							for j := 1 to arrOlahan.neffOlahan do
							begin
								temp := '';
							
								for k := 1 to arrOlahan.arrBahanOlahan[j].jumlahBahan do
								begin
									if (k <> arrOlahan.arrBahanOlahan[j].jumlahBahan) then
									begin
										temp := temp + arrOlahan.arrBahanOlahan[j].bahanPembuat[k] + ' | ';
									end else
									begin
										temp := temp + arrOlahan.arrBahanOlahan[j].bahanPembuat[k];
									end;
								end;
							
								kata := arrOlahan.arrBahanOlahan[j].nama + ' | ' + IntToStr(arrOlahan.arrBahanOlahan[j].hargaJual) + ' | ' + 
										IntToStr(arrOlahan.arrBahanOlahan[j].jumlahBahan) + ' | ' + temp + ' ';
							
								writeln(inf, kata);
							end;
						
							close(inf);
						end;
						
				3	:	begin
							assign(inf,'FileInvMentah.txt');
							rewrite(inf);
						
							for j := 1 to arrInvMentah.neffMentah do
							begin
								kata := arrInvMentah.arrayMentah[j].nama + ' | ' + IntToStr(arrInvMentah.arrayMentah[j].tglBeli.hari) + '/' + 
										IntToStr(arrInvMentah.arrayMentah[j].tglBeli.bulan) + '/' + IntToStr(arrInvMentah.arrayMentah[j].tglBeli.tahun) + ' | ' +
										IntToStr(arrInvMentah.arrayMentah[j].tglKdlMentah.hari) + '/' + 
										IntToStr(arrInvMentah.arrayMentah[j].tglKdlMentah.bulan) + '/' + IntToStr(arrInvMentah.arrayMentah[j].tglKdlMentah.tahun) + ' | ' 
										+ IntToStr(arrInvMentah.arrayMentah[j].jumlah) + ' ';
							
								writeln(inf, kata);
							end;
			
							close(inf);
						end;
					
				4	:	begin
							assign(inf,'FileInvOlahan.txt');
							rewrite(inf);
						
							for j := 1 to arrInvOlahan.neffOlahan do
							begin
								kata := arrInvOlahan.arrayOlahan[j].nama + ' | ' + IntToStr(arrInvOlahan.arrayOlahan[j].tglBuat.hari) + '/' + 
										IntToStr(arrInvOlahan.arrayOlahan[j].tglBuat.bulan) + '/' + IntToStr(arrInvOlahan.arrayOlahan[j].tglBuat.tahun) + ' | ' + IntToStr(arrInvOlahan.arrayOlahan[j].tglKdlOlahan.hari) + '/' + 
										IntToStr(arrInvOlahan.arrayOlahan[j].tglKdlOlahan.bulan) + '/' + IntToStr(arrInvOlahan.arrayOlahan[j].tglKdlOlahan.tahun) + ' | '
										+ IntToStr(arrInvOlahan.arrayOlahan[j].hargaJual) + ' | ' + IntToStr(arrInvOlahan.arrayOlahan[j].jumlah) + ' ';
							
								writeln(inf, kata);
							end;

							close(inf);
						end;
					
				5	:	begin
							assign(inf,'FileResep.txt');
							rewrite(inf);
						
							for j := 1 to arrResep.neffResep do
							begin
								temp := '';
							
								for k := 1 to arrResep.arrayResep[j].jumlahBahan do
								begin
									if (k <> arrResep.arrayResep[j].jumlahBahan) then
									begin
										temp := temp + arrResep.arrayResep[j].bahanPembuat[k] + ' | ';
									end else
									begin
										temp := temp + arrResep.arrayResep[j].bahanPembuat[k];
									end;
								end;
							
								kata := arrResep.arrayResep[j].nama + ' | ' + IntToStr(arrResep.arrayResep[j].hargaJual) + ' | ' + 
										IntToStr(arrResep.arrayResep[j].jumlahBahan) + ' | ' + temp + ' ';
									
								writeln(inf, kata);
							end;
						
							close(inf);
						end;
					
				6	:	begin
							assign(inf,'FileSimulasi.txt');
							rewrite(inf);	
						
							for j := 1 to arrSimulasi.neffSimulasi do
							begin
								kata := IntToStr(arrSimulasi.arraySimulasi[j].nomor) + ' | ' + IntToStr(arrSimulasi.arraySimulasi[j].tanggalSimulasi.hari) + '/' + 
										IntToStr(arrSimulasi.arraySimulasi[j].tanggalSimulasi.bulan) + '/' + 
										IntToStr(arrSimulasi.arraySimulasi[j].tanggalSimulasi.tahun) + ' | ' +
										IntToStr(arrSimulasi.arraySimulasi[j].jumlahHari) + ' | ' + IntToStr(arrSimulasi.arraySimulasi[j].jumlahEnergi) + ' | ' +
										IntToStr(arrSimulasi.arraySimulasi[j].maksInvmentah) + ' | ' + IntToStr(arrSimulasi.arraySimulasi[j].maksInvOlahan) + ' | ' +
										IntToStr(arrSimulasi.arraySimulasi[j].totalMentahDibeli) + ' | ' + 
										IntToStr(arrSimulasi.arraySimulasi[j].totalOlahanDibuat) + ' | ' +
										IntToStr(arrSimulasi.arraySimulasi[j].totalOlahanDijual) + ' | ' + 
										IntToStr(arrSimulasi.arraySimulasi[j].totalResepDijual) + ' | ' +
										IntToStr(arrSimulasi.arraySimulasi[j].totalPemasukan) + ' | ' +
										IntToStr(arrSimulasi.arraySimulasi[j].totalPengeluaran) + ' | ' + IntToStr(arrSimulasi.arraySimulasi[j].totalUang) + ' ';
							
								writeln(inf, kata);
							end;
				
							close(inf);
						end;
			end;
		end;
	
	writeln(' File berhasil disimpan');
	writeln(' Kamu telah keluar dari program');
end;

end.