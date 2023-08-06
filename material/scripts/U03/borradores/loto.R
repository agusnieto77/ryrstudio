require(rvest)
url <- 'https://www.loteriasmundiales.com.ar/Quinielas/buenos-aires'
read_html(url) |> html_table()

url <- 'https://vivitusuerte.com/pizarra/ciudad'
read_html(url) |> html_table()

url <- 'https://notitimba.com/lots/'
read_html(url) |> html_table()

url <- 'https://www.jugandoonline.com.ar/SorteosQuiniela3.aspx'
read_html(url) |> html_table()

url <- 'http://www.quinielasandiego.com.ar/?c=quiniela&fecha=Lunes%2005/09/22&turno=Nocturna'
read_html(url) |> html_table()

url <- 'https://www.clarin.com/loterias-y-quinielas/'
read_html(url) |> html_table()

url <- 'https://www.lanacion.com.ar/loterias/quiniela-nacional/'
read_html(url) |> html_table()

url <- 'https://loteria.guru/resultados-loteria-argentina/ar-quiniela-de-la-ciudad'
read_html(url) |> html_table()

