select * from Dim_Aeropuerto where codigo IN ('AEP', 'BRC', 'COR', 'EPA', 'EZE', 'MDZ', 'SLA');

obtener las medias de los items de las encuestas de los aeropuertos != Argentina agrupadas por PaisResidencia, Genero y RangoEdad

copy(
select pa.descripcion as PaisResidencia, ge.descripcion as Genero, re.descripcion as RangoEdad, count(*) as Cantidad,
	
	round(avg(e.Transporte),3) as Transporte, round(avg(e.Parking),3) as Parking, round(avg(e.ParkingRelPrecioCal),3) as ParkingRelPrecioCal, round(avg(e.DispCarritos),3) as DispCarritos,
	round(avg(e.CheckInTiempEspera),3) as CheckInTiempEspera, round(avg(e.CheckInEficiencia),3) as CheckInEficiencia, round(avg(e.CheckInCortesia),3) as CheckInCortesia,
	round(avg(e.CtrlPasTiempoEspera),3) as CtrlPasTiempoEspera, round(avg(e.CtrlPasCortesia),3) as CtrlPasCortesia, round(avg(e.SegCortesia),3) as SegCortesia, round(avg(e.SegMeticulosidad),3) as SegMeticulosidad,
	round(avg(e.SegTiempoEspera),3) as SegTiempoEspera, round(avg(e.SegSensacionProt),3) as SegSensacionProt, round(avg(e.OrientSenalizacion),3) as OrientSenalizacion,
	round(avg(e.OrientPantallaInfo),3) as OrientPantallaInfo, round(avg(e.OientDistancia),3) as OientDistancia, round(avg(e.OrientFacilidConexion),3) as OrientFacilidConexion,
	round(avg(e.InstalCortesia),3) as InstalCortesia, round(avg(e.InstalRestaurant),3) as InstalRestaurant, round(avg(e.InstalRestaurantRelPrecioCal),3) as InstalRestaurantRelPrecioCal,
	round(avg(e.InstalDispBancoATM),3) as InstalDispBancoATM, round(avg(e.InstalTiendas),3) as InstalTiendas, round(avg(e.InstalTiendasRelPrecioCal),3) as InstalTiendasRelPrecioCal,
	round(avg(e.InstalInternetWIFI),3) as InstalInternetWIFI, round(avg(e.InstalSalasVip),3) as InstalSalasVip, round(avg(e.InstalBanosDisp),3) as InstalBanosDisp,
	round(avg(e.InstalBanosLimpieza),3) as InstalBanosLimpieza, round(avg(e.InstalComodidadZonaEspera),3) as InstalComodidadZonaEspera, round(avg(e.InstalLimpiezaGeneral),3) as InstalLimpiezaGeneral,
	round(avg(e.InstalAmbiente),3) as InstalAmbiente, round(avg(e.SatisfaccionGeneral),3) as SatisfaccionGeneral, round(avg(e.ControlPasaportes),3) as ControlPasaportes,
	round(avg(e.RapidesEntregaEquipaje),3) as RapidesEntregaEquipaje, round(avg(e.ControlAduanero),3) as ControlAduanero

	from fact_encuesta e
	join fact_vuelo v ON e.idvuelo = v.idvuelo
	join dim_tipocliente tc ON e.idtipocliente = tc.idtipocliente
	join dim_pais pa ON tc.idpaisresidencia = pa.idpais
	join dim_genero ge ON tc.idgenero = ge.idgenero
	join dim_rangoedad re ON tc.idrangoedad = re.idrangoedad
	where
		v.aeropcodigosalida in ('AEP', 'BRC', 'COR','EPA', 'EZE', 'MDZ', 'SLA')		
	group by
		pa.descripcion, ge.descripcion, re.descripcion
) to '/tmp/2.EncuestaCalidadAeropuerosArgentina.csv' with csv HEADER;