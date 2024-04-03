SELECT 
	LEFT ( p.kd_kemdagri, 6 ) kode_kec,
	LEFT ( w.kode_bps, 7 ) kode_kec_bps,
	p.kabkot,
	p.kec,
	count(i.id_keluarga) jml_pend_miskin,
	sum(case when i.usia_2023 between 0 and 5 then 1 else 0 end) jml_balita_miskin_0_5,
	sum(case when i.usia_2023 between 6 and 14 then 1 else 0 end) jml_anak_miskin_6_14,
	sum(case when i.usia_2023 between 15 and 60 then 1 else 0 end) jml_pend_usia_produktif_miskin_15_60,
	sum(case when i.usia_2023 > 60 then 1 else 0 end) 'jml_lansia_miskin_60+',
	sum(case when i.pendidikan = 'Tamat SD/Sederajat' then 1 else 0 end) jml_pend_miskin_tamatan_sd,
	sum(case when i.pendidikan = 'Tamat SLTP/Sederajat' then 1 else 0 end) jml_pend_miskin_tamatan_smp,	
	sum(case when i.pendidikan = 'Tamat SLTA/Sederajat' then 1 else 0 end) jml_pend_miskin_tamatan_sma,	
	sum(case when i.pendidikan = 'Tamat PT/Akademi' then 1 else 0 end) jml_pend_miskin_tamatan_pt,
	sum(case when p.kepemilikan_rumah = 'Milik Sendiri' then 1 else 0 end) jml_pend_dengan_rumah_sendiri,
	sum(case when p.sumber_air in ('Sumur Terlindung', 'Sumur Bor', 'Air Kemasan/Isi Ulang') then 1 else 0 end) jml_pend_dengan_air_tanah,
	sum(case when p.sumber_air in ('Sumur Tidak Terlindung', 'Air Hujan', 'Air Permukaan (Sungai, Danau, dll)') then 1 else 0 end) jml_pend_dengan_air_permukaan,
	sum(case when p.fas_bab = 'Milik sendiri' then 1 else 0 end) jml_pend_fas_bab_sendiri,
	sum(case when p.fas_bab = 'Umum/Bersama' then 1 else 0 end) jml_pend_fas_umum,
	sum(case when p.jns_lantai in ('Keramik/Granit/Marmer/Ubin/Tegel/Teraso', 'Semen', 'Kayu/Papan') then 1 else 0 end) jml_pend_lantai_diperkeras,
	sum(case when p.jns_lantai in ('Tanah', 'Bambu') then 1 else 0 end) jml_pend_lantai_belum_diperkeras,
	sum(case when p.sumber_penerangan in ('Listrik PLN meteran', 'Listrik PLN non meteran', 'Listrik non-PLN') then 1 else 0 end) jml_pend_berlistrik,
	sum(case when p.sumber_penerangan = 'Bukan listrik' then 1 else 0 end) jml_pend_belum_berlistrik,
	sum(case when i.pekerjaan in ('Pedagang', 'Wiraswasta') then 1 else 0 end) jml_pend_pedagang_dan_wiraswasta
FROM
	p3ke23_kel p
		JOIN wilayah_dagri_bps w ON p.kd_kemdagri = w.kode_dagri 
		JOIN p3ke23_individu i ON p.id_keluarga = i.id_keluarga
WHERE
	i.desil = 1
GROUP BY
	1