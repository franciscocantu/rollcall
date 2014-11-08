## GETS DATA FOR PROPOSICIONESS FROM DIPUTDOS WEB

rm(list = ls())
## PATH TO WORKING DIRECTORY IN DISK
#DipMex <- c("d:/01/Dropbox/data/rollcall/dipMex")
DipMex <- c("~/Dropbox/data/rollcall/dipMex")
#DipMex <- c("C:/Documents and Settings/emm/Mis documentos/My Dropbox/data/rollcall/dipMex")
#DipMex <- c("C:/Documents and Settings/emagarm/Mis documentos/My Dropbox/data/rollcall/dipMex")
setwd(DipMex)

webPath <- c("http://gaceta.diputados.gob.mx/Gaceta/Proposiciones")


#######################################################
## DOWNLOAD HTML CODE WITH PROPOSICION DESCRIPTIONS  ##
## ** RUN DIRECTLY IN TERMINAL **                    ##
#######################################################

wget http://gaceta.diputados.gob.mx/Gaceta/Proposiciones/59/gp59_P_a1primero.html
wget http://gaceta.diputados.gob.mx/Gaceta/Proposiciones/59/gp59_P_a1perma1.html   
wget http://gaceta.diputados.gob.mx/Gaceta/Proposiciones/59/gp59_P_a1segundo.html
wget http://gaceta.diputados.gob.mx/Gaceta/Proposiciones/59/gp59_P_a2primero.html
wget http://gaceta.diputados.gob.mx/Gaceta/Proposiciones/59/gp59_P_a2perma1.html 
wget http://gaceta.diputados.gob.mx/Gaceta/Proposiciones/59/gp59_P_a2segundo.html
wget http://gaceta.diputados.gob.mx/Gaceta/Proposiciones/59/gp59_P_a3primero.html
wget http://gaceta.diputados.gob.mx/Gaceta/Proposiciones/59/gp59_P_a3perma1.html 
wget http://gaceta.diputados.gob.mx/Gaceta/Proposiciones/59/gp59_P_a3segundo.html

wget http://gaceta.diputados.gob.mx/Gaceta/Proposiciones/60/gp60_P_a1perma1.html   
wget http://gaceta.diputados.gob.mx/Gaceta/Proposiciones/60/gp60_P_a1perma2.html 
wget http://gaceta.diputados.gob.mx/Gaceta/Proposiciones/60/gp60_P_a1primero.html
wget http://gaceta.diputados.gob.mx/Gaceta/Proposiciones/60/gp60_P_a1segundo.html
wget http://gaceta.diputados.gob.mx/Gaceta/Proposiciones/60/gp60_P_a2perma1.html 
wget http://gaceta.diputados.gob.mx/Gaceta/Proposiciones/60/gp60_P_a2perma2.html 
wget http://gaceta.diputados.gob.mx/Gaceta/Proposiciones/60/gp60_P_a2primero.html
wget http://gaceta.diputados.gob.mx/Gaceta/Proposiciones/60/gp60_P_a2segundo.html
wget http://gaceta.diputados.gob.mx/Gaceta/Proposiciones/60/gp60_P_a3perma1.html 
wget http://gaceta.diputados.gob.mx/Gaceta/Proposiciones/60/gp60_P_a3perma2.html 
wget http://gaceta.diputados.gob.mx/Gaceta/Proposiciones/60/gp60_P_a3primero.html
wget http://gaceta.diputados.gob.mx/Gaceta/Proposiciones/60/gp60_P_a3segundo.html

wget http://gaceta.diputados.gob.mx/Gaceta/Proposiciones/61/gp61_P_a1perma1.html 
wget http://gaceta.diputados.gob.mx/Gaceta/Proposiciones/61/gp61_P_a1perma2.html 
wget http://gaceta.diputados.gob.mx/Gaceta/Proposiciones/61/gp61_P_a1primero.html
wget http://gaceta.diputados.gob.mx/Gaceta/Proposiciones/61/gp61_P_a1segundo.html                     
wget http://gaceta.diputados.gob.mx/Gaceta/Proposiciones/61/gp61_P_a2perma1.html 
wget http://gaceta.diputados.gob.mx/Gaceta/Proposiciones/61/gp61_P_a2perma2.html 
wget http://gaceta.diputados.gob.mx/Gaceta/Proposiciones/61/gp61_P_a2primero.html
wget http://gaceta.diputados.gob.mx/Gaceta/Proposiciones/61/gp61_P_a2segundo.html
wget http://gaceta.diputados.gob.mx/Gaceta/Proposiciones/61/gp61_P_a3perma1.html 
wget http://gaceta.diputados.gob.mx/Gaceta/Proposiciones/61/gp61_P_a3primero.html
wget http://gaceta.diputados.gob.mx/Gaceta/Proposiciones/61/gp61_P_a3segundo.html

## Esto los convierte de iso-8859-1 a utf-8 para trabajar en ubuntu
iconv -f Latin1 -t UTF-8 gp59_P_a1primero.html  > utf8.gp59_P_a1primero.html  
iconv -f Latin1 -t UTF-8 gp59_P_a1perma1.html   > utf8.gp59_P_a1perma1.html  
iconv -f Latin1 -t UTF-8 gp59_P_a1segundo.html  > utf8.gp59_P_a1segundo.html
iconv -f Latin1 -t UTF-8 gp59_P_a2primero.html  > utf8.gp59_P_a2primero.html
iconv -f Latin1 -t UTF-8 gp59_P_a2perma1.html   > utf8.gp59_P_a2perma1.html 
iconv -f Latin1 -t UTF-8 gp59_P_a2segundo.html  > utf8.gp59_P_a2segundo.html
iconv -f Latin1 -t UTF-8 gp59_P_a3primero.html  > utf8.gp59_P_a3primero.html
iconv -f Latin1 -t UTF-8 gp59_P_a3perma1.html   > utf8.gp59_P_a3perma1.html 
iconv -f Latin1 -t UTF-8 gp59_P_a3segundo.html  > utf8.gp59_P_a3segundo.html

iconv -f Latin1 -t UTF-8 gp60_P_a1perma1.html   > utf8.gp60_P_a1perma1.html  
iconv -f Latin1 -t UTF-8 gp60_P_a1perma2.html   > utf8.gp60_P_a1perma2.html 
iconv -f Latin1 -t UTF-8 gp60_P_a1primero.html  > utf8.gp60_P_a1primero.html
iconv -f Latin1 -t UTF-8 gp60_P_a1segundo.html  > utf8.gp60_P_a1segundo.html
iconv -f Latin1 -t UTF-8 gp60_P_a2perma1.html   > utf8.gp60_P_a2perma1.html 
iconv -f Latin1 -t UTF-8 gp60_P_a2perma2.html   > utf8.gp60_P_a2perma2.html 
iconv -f Latin1 -t UTF-8 gp60_P_a2primero.html  > utf8.gp60_P_a2primero.html
iconv -f Latin1 -t UTF-8 gp60_P_a2segundo.html  > utf8.gp60_P_a2segundo.html
iconv -f Latin1 -t UTF-8 gp60_P_a3perma1.html   > utf8.gp60_P_a3perma1.html 
iconv -f Latin1 -t UTF-8 gp60_P_a3perma2.html   > utf8.gp60_P_a3perma2.html 
iconv -f Latin1 -t UTF-8 gp60_P_a3primero.html  > utf8.gp60_P_a3primero.html
iconv -f Latin1 -t UTF-8 gp60_P_a3segundo.html  > utf8.gp60_P_a3segundo.html

iconv -f Latin1 -t UTF-8 gp61_P_a1perma1.html   > utf8.gp61_P_a1perma1.html 
iconv -f Latin1 -t UTF-8 gp61_P_a1perma2.html   > utf8.gp61_P_a1perma2.html 
iconv -f Latin1 -t UTF-8 gp61_P_a1primero.html  > utf8.gp61_P_a1primero.html
iconv -f Latin1 -t UTF-8 gp61_P_a1segundo.html  > utf8.gp61_P_a1segundo.html                    
iconv -f Latin1 -t UTF-8 gp61_P_a2perma1.html   > utf8.gp61_P_a2perma1.html 
iconv -f Latin1 -t UTF-8 gp61_P_a2perma2.html   > utf8.gp61_P_a2perma2.html 
iconv -f Latin1 -t UTF-8 gp61_P_a2primero.html  > utf8.gp61_P_a2primero.html
iconv -f Latin1 -t UTF-8 gp61_P_a2segundo.html  > utf8.gp61_P_a2segundo.html
iconv -f Latin1 -t UTF-8 gp61_P_a3perma1.html   > utf8.gp61_P_a3perma1.html 
iconv -f Latin1 -t UTF-8 gp61_P_a3primero.html  > utf8.gp61_P_a3primero.html
iconv -f Latin1 -t UTF-8 gp61_P_a3segundo.html  > utf8.gp61_P_a3segundo.html


################################################
### LISTS FROM GACETAS'S LISTA ORDENADA       ##
## each period's file lists all proposiciones ##
################################################

per61 <- c(
"gp61_P_a1primero",
"gp61_P_a1perma1",
"gp61_P_a1segundo",
"gp61_P_a1perma2",
"gp61_P_a2primero",
"gp61_P_a2perma1",
"gp61_P_a2segundo",
"gp61_P_a2perma2",
"gp61_P_a3primero",
"gp61_P_a3perma1",
"gp61_P_a3segundo"
    )

per60 <- c(
"gp60_P_a1primero",
"gp60_P_a1perma1",
"gp60_P_a1segundo",
"gp60_P_a1perma2",
"gp60_P_a2primero",
"gp60_P_a2perma1",
"gp60_P_a2segundo",
"gp60_P_a2perma2",
"gp60_P_a3primero",
"gp60_P_a3perma1",
"gp60_P_a3segundo",
"gp60_P_a3perma2"
    )

per59 <- c(
"gp59_P_a1primero",
"gp59_P_a1perma1",
"gp59_P_a1segundo",
"gp59_P_a2primero",
"gp59_P_a2perma1",
"gp59_P_a2segundo",
"gp59_P_a3primero",
"gp59_P_a3perma1",
"gp59_P_a3segundo"
    )

## ## DOWNLOADS HTML CODE
## n <- 1
## N<-length(periodos)
## for (n in 1:N){  ## PRONE TO CRASHES IF CAMARA WEB SLOW --- RESTART SEQUENCE AFTER LAST n
##    direc <- paste(webPath, leg, paste(periodos, ".html", sep="")[n], sep="/")
##    url<-url(direc, open="r", encoding = "ISO-8859-1")
##    tmp<-c("marimba tropical sedna periodo ", periodos[n], readLines(url)) ## ADD STRING TO LOCATE RECORD START
##    close(url)
##    filename<-paste(DipMex, "/matweb/proposiciones/listsHtml/", periodos[n], ".txt",sep="")
##    write.table(tmp, filename, sep="\t")
##    cat("loop = ", n, "of", N, "\n", sep=" ")
##     }


#############################
##   PARSE HTML CONTENT    ##
#############################

leg <- 61
periodos <- per61

N <- length(periodos)
tmp <- rep(NA, times=N)
dat <- data.frame(dy=tmp, mo=tmp, yr=tmp, favor=tmp, contra=tmp, absten=tmp, quorum=tmp, ausen=tmp, title=tmp)

## # prueba todos los encodings disponibles
## enc <- iconvlist();
## tmp2 <- rep(NA, length(enc))
## ies <- 93:350
## for (i in ies){#:length(enc)){
##     tmp <- read.table(filename, sep = "\t", fileEncoding = enc[i], )
##     tmp <- as.vector(tmp[,])
##     tmp2[i] <- tmp[59]
##     cat(paste("loop", i, "\n"))
## }

#Sys.setlocale(category = "LC_ALL", locale = "C")
#Sys.setlocale(category = "LC_ALL", locale = "en_US.UTF-8")
#Sys.setlocale(category = "LC_ALL", locale = "Spanish_Mexico.1252")

n <- 1
#for (n in 1:N){
    filename <- paste(DipMex, "/matweb/proposiciones/listsHtml/utf8.", periodos[n], ".html", sep="")
#    filename <- paste(DipMex, "/matweb/proposiciones/listsHtml/", periodos[n], ".html", sep="")
    tmp <- readLines(filename, encoding = "UTF-8") #, encoding = "ISO-8859-1") #encoding = "WINDOWS-1252")
    tmp2 <- grep(tmp, pattern="<ul><li>")
    props <- tmp[tmp2+1]
    tmp2 <- grep(tmp, pattern="</li></ul>")
    tmp3 <- tmp[tmp2-1]
    fecha <- sub(tmp3, pattern=".*n�mero [0-9]*-.*, (.*)[.].*$", replacement="\\1")
    yr <- sub(fecha, pattern = ".* de ([0-9]*)", replacement = "\\1")
    mo <- sub(fecha, pattern = ".*[0-9] de (.*) de.*", replacement = "\\1")
    mo <- sub(mo, pattern="enero", replacement="1")
    mo <- sub(mo, pattern="febrero", replacement="2")
    mo <- sub(mo, pattern="marzo", replacement="3")
    mo <- sub(mo, pattern="abril", replacement="4")
    mo <- sub(mo, pattern="mayo", replacement="5")
    mo <- sub(mo, pattern="junio", replacement="6")
    mo <- sub(mo, pattern="julio", replacement="7")
    mo <- sub(mo, pattern="agosto", replacement="8")
    mo <- sub(mo, pattern="septiembre", replacement="9")
    mo <- sub(mo, pattern="octubre", replacement="10")
    mo <- sub(mo, pattern="noviembre", replacement="11")
    mo <- sub(mo, pattern="diciembre", replacement="12")
    mo <- as.numeric(mo)
    dy <- sub(fecha, pattern = ".* ([0-9]*) de.*", replacement = "\\1"); dy <- as.numeric(dy)

    title <- sub(tmp3, pattern="\\Q\"\\E", replacement="")
    fecha <- sub(tmp[tmp2+1], pattern=".*<br> ([0-9]{1,2}/[0-9]{1,2}/[0-9]{2,4}).*", replacement="\\1")
    tmp2 <- grep(tmp, pattern="lola.11.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    favor <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    tmp2 <- grep(tmp, pattern="lola.12.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    contra <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    tmp2 <- grep(tmp, pattern="lola.13.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    absten <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    tmp2 <- grep(tmp, pattern="lola.14.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    quorum <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    tmp2 <- grep(tmp, pattern="lola.15.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    ausen <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    dat$dy[n]  <- dy
    dat$mo[n]  <- mo
    dat$yr[n]  <- yr

    dat$favor[n]  <- favor
    dat$contra[n] <- contra
    dat$absten[n] <- absten
    dat$quorum[n] <- quorum
    dat$ausen[n]  <- ausen
#              }

dat61 <- dat






#######################
### 5X LEGISLATURA  ###
#######################

## list59.txt IS THE CODE CREATING THE PAGE AT http://gaceta.diputados.gob.mx/Gaceta/Votaciones/59/
list <- readLines(paste(DipMex, "/matweb/tablas/59/list59.txt", sep=""))
#
tmp <- grep(list, pattern=".*>Votaci�n</a>.$")
tmp2 <- sub(list[tmp], pattern=".*<a href=(.*)>Votaci�n</a>.$", replacement="\\1")
fls59 <- sub(tmp2, pattern=".*(tabla.*.php3).*", replacement="\\1")
#
tabs59 <- sub(fls59, pattern=".php3", replacement="")

### DONE IN MY MACHINE
#path<-c("http://gaceta.diputados.gob.mx/Gaceta/Votaciones/59/")
#N<-length(tabs59)
#for (n in 1:N){
#    direc<-paste(path,fls59[n],sep="")
#    url<-url(direc,open="r")
#    tmp<-c("cacapunchis registro ",tabs59[n],readLines(url))
#    close(url)
#    filename<-paste(DipMex, "/matweb/tablas/59/",tabs59[n],".txt",sep="")
#    write.table(tmp, filename, sep="\t")
#}

# files before 2006, HAD MISTAKENLY FORGOTTEN THESE

path<-c("http://gaceta.diputados.gob.mx/Gaceta/Votaciones/59/")
dir<-paste(DipMex, "/matweb/tablas/59/", sep="")
#
secuencia <- c(1:162) ## TRIAL AND ERROR, START WITH ALL, DROPPING THOSE THAT BREAK --- TRIED TIL 171
fls <- paste("tabla2or1-", secuencia, ".php3", sep="")
tabs <- sub(fls, pattern=".php3", replacement="")
#
dontdo <- file.exists( paste(dir,"tabla2or1-", secuencia,".txt", sep="") )
tmp <- 1:length(secuencia)
work <- tmp[dontdo=="FALSE"]
#
for (n in work){
    direc<-paste(path,fls[n],sep="")
    url<-url(direc,open="r")
    tmp<-c("cacapunchis registro ",tabs[n],readLines(url))
    close(url)
    filename<-paste(dir,tabs[n],".txt",sep="")
    write.table(tmp, filename, sep="\t")
}
#
fls59bis <- fls
tabs59bis <- tabs
#
secuencia <- c(1:19, 21:85) ## TRIAL AND ERROR, START WITH ALL, DROPPING THOSE THAT BREAK --- PROB� HASTA 90
fls <- paste("tabla2or2-", secuencia, ".php3", sep="")
tabs <- sub(fls, pattern=".php3", replacement="")
#
dontdo <- file.exists( paste(dir,"tabla2or2-", secuencia,".txt", sep="") )
tmp <- 1:length(secuencia)
work <- tmp[dontdo=="FALSE"]
#
for (n in work){
    direc<-paste(path,fls[n],sep="")
    url<-url(direc,open="r")
    tmp<-c("cacapunchis registro ",tabs[n],readLines(url))
    close(url)
    filename<-paste(dir,tabs[n],".txt",sep="")
    write.table(tmp, filename, sep="\t")
}
fls59bis <- append(fls59bis,fls)
tabs59bis <- append(tabs59bis,tabs)
#
secuencia <- c(1:115, 117:156) ## TRIAL AND ERROR, START WITH ALL, DROPPING THOSE THAT BREAK --- PROB� HASTA 161
fls <- paste("tabla3or1-", secuencia, ".php3", sep="")
tabs <- sub(fls, pattern=".php3", replacement="")
#
dontdo <- file.exists( paste(dir,"tabla3or1-", secuencia,".txt", sep="") )
tmp <- 1:length(secuencia)
work <- tmp[dontdo=="FALSE"]
#
for (n in work){
    direc<-paste(path,fls[n],sep="")
    url<-url(direc,open="r")
    tmp<-c("cacapunchis registro ",tabs[n],readLines(url))
    close(url)
    filename<-paste(dir,tabs[n],".txt",sep="")
    write.table(tmp, filename, sep="\t")
}
fls59bis <- append(fls59bis,fls)
tabs59bis <- append(tabs59bis,tabs)
#
secuencia <- c(1:29,31:49,51:57) ## TRIAL AND ERROR, START WITH ALL, DROPPING THOSE THAT BREAK --- PROB� HASTA 63
fls <- paste("tabla1or2-", secuencia, ".php3", sep="")
tabs <- sub(fls, pattern=".php3", replacement="")
#
dontdo <- file.exists( paste(dir,"tabla1or2-", secuencia,".txt", sep="") )
tmp <- 1:length(secuencia)
work <- tmp[dontdo=="FALSE"]
#
for (n in work){
    direc<-paste(path,fls[n],sep="")
    url<-url(direc,open="r")
    tmp<-c("cacapunchis registro ",tabs[n],readLines(url))
    close(url)
    filename<-paste(dir,tabs[n],".txt",sep="")
    write.table(tmp, filename, sep="\t")
}
fls59bis <- append(fls59bis,fls)
tabs59bis <- append(tabs59bis,tabs)
#
secuencia <- c(3:7,9,13,17:26,28:30,41:48,50:51,55:56,59:61,63:91) ## TRIAL AND ERROR, START WITH ALL, DROPPING THOSE THAT BREAK --- PROB� HASTA 101
fls <- paste("tabla1or1-", secuencia, ".php3", sep="")
tabs <- sub(fls, pattern=".php3", replacement="")
#
dontdo <- file.exists( paste(dir,"tabla1or1-", secuencia,".txt", sep="") )
tmp <- 1:length(secuencia)
work <- tmp[dontdo=="FALSE"]
#
for (n in work){
    direc<-paste(path,fls[n],sep="")
    url<-url(direc,open="r")
    tmp<-c("cacapunchis registro ",tabs[n],readLines(url))
    close(url)
    filename<-paste(dir,tabs[n],".txt",sep="")
    write.table(tmp, filename, sep="\t")
}
fls59bis <- append(fls59bis,fls)
tabs59bis <- append(tabs59bis,tabs)
#
secuencia <- c(96,103,108,110,117,142)
fls <- paste("tabla3or2-", secuencia, ".php3", sep="")
tabs <- sub(fls, pattern=".php3", replacement="")
#
dontdo <- file.exists( paste(dir,"tabla3or2-", secuencia,".txt", sep="") )
tmp <- 1:length(secuencia)
work <- tmp[dontdo=="FALSE"]
#
for (n in work){
    direc<-paste(path,fls[n],sep="")
    url<-url(direc,open="r")
    tmp<-c("cacapunchis registro ",tabs[n],readLines(url))
    close(url)
    filename<-paste(dir,tabs[n],".txt",sep="")
    write.table(tmp, filename, sep="\t")
}
fls59bis <- append(fls59bis,fls)
tabs59bis <- append(tabs59bis,tabs)
#
secuencia <- c(1:18) ## TRIAL AND ERROR, START WITH ALL, DROPPING THOSE THAT BREAK --- PROB� HASTA 22
fls <- paste("tabla2extra1-", secuencia, ".php3", sep="")
tabs <- sub(fls, pattern=".php3", replacement="")
#
dontdo <- file.exists( paste(dir,"tabla2extra1-", secuencia,".txt", sep="") )
tmp <- 1:length(secuencia)
work <- tmp[dontdo=="FALSE"]
#
for (n in work){
    direc<-paste(path,fls[n],sep="")
    url<-url(direc,open="r")
    tmp<-c("cacapunchis registro ",tabs[n],readLines(url))
    close(url)
    filename<-paste(dir,tabs[n],".txt",sep="")
    write.table(tmp, filename, sep="\t")
}
fls59bis <- append(fls59bis,fls)
tabs59bis <- append(tabs59bis,tabs)

secuencia <- c(1:9) ## trial and error, start with all, dropping those that break --- prob� hasta 12
fls <- paste("tabla1extra2-", secuencia, ".php3", sep="")
tabs <- sub(fls, pattern=".php3", replacement="")
#
dontdo <- file.exists( paste(dir,"tabla1extra2-", secuencia,".txt", sep="") )
tmp <- 1:length(secuencia)
work <- tmp[dontdo=="FALSE"]
#
for (n in work){
    direc<-paste(path,fls[n],sep="")
    url<-url(direc,open="r")
    tmp<-c("cacapunchis registro ",tabs[n],readLines(url))
    close(url)
    filename<-paste(dir,tabs[n],".txt",sep="")
    write.table(tmp, filename, sep="\t")
}
fls59bis <- append(fls59bis,fls)
tabs59bis <- append(tabs59bis,tabs)

#setwd(paste(DipMex, "/matweb/tablas/59", sep="")
#allf <- dir(pattern="tabla[1|2or1|2]|[3or1]-.*")
#allf <- sub(allf, pattern=".txt", replacement="")
#setdiff(allf, tabs59bis)

##################################################################################
##################################################################################
#########  61 legislatura                                            #############
##################################################################################
##################################################################################

path<-c("http://gaceta.diputados.gob.mx/Gaceta/Votaciones/61/")
dir<-paste(DipMex, "/matweb/tablas/61/", sep="")
#
## I'VE DOWNLOADED FILES UP TO 9MAY2011 (END OF DE 61YR2OR2) <---- OJO, UPDATES CARRIED DIFFERENTLY BELOW, FROM INFOPAL
#
fls61 <- c("tabla1or1-1.php3", "tabla1or1-2.php3",
"tabla1or1-3.php3", "tabla1or1-4.php3", "tabla1or1-5.php3",
"tabla1or1-6.php3", "tabla1or1-7.php3", "tabla1or1-8.php3",
"tabla1or1-9.php3", "tabla1or1-10.php3", "tabla1or1-11.php3",
"tabla1or1-12.php3", "tabla1or1-13.php3", "tabla1or1-14.php3",
"tabla1or1-15.php3", "tabla1or1-16.php3", "tabla1or1-17.php3",
"tabla1or1-18.php3", "tabla1or1-19.php3", "tabla1or1-20.php3",
"tabla1or1-21.php3", "tabla1or1-22.php3", "tabla1or1-23.php3",
"tabla1or1-24.php3", "tabla1or1-25.php3", "tabla1or1-26.php3",
"tabla1or1-27.php3", "tabla1or1-28.php3", "tabla1or1-29.php3",
"tabla1or1-30.php3", "tabla1or1-31.php3", "tabla1or1-32.php3",
"tabla1or2-1.php3", "tabla1or2-2.php3", "tabla1or2-3.php3",
"tabla1or2-4.php3", "tabla1or2-5.php3", "tabla1or2-6.php3",
"tabla1or2-7.php3", "tabla1or2-8.php3", "tabla1or2-9.php3",
"tabla1or2-10.php3", "tabla1or2-11.php3", "tabla1or2-12.php3",
"tabla1or2-13.php3", "tabla1or2-14.php3", "tabla1or2-15.php3",
"tabla1or2-16.php3", "tabla1or2-17.php3", "tabla1or2-18.php3",
"tabla1or2-19.php3", "tabla1or2-20.php3", "tabla1or2-21.php3",
"tabla1or2-22.php3", "tabla1or2-23.php3", "tabla1or2-24.php3",
"tabla1or2-25.php3", "tabla1or2-26.php3", "tabla1or2-27.php3",
"tabla1or2-28.php3", "tabla1or2-29.php3", "tabla1or2-30.php3",
"tabla1or2-31.php3", "tabla1or2-32.php3", "tabla1or2-33.php3",
"tabla1or2-34.php3", "tabla1or2-35.php3", "tabla1or2-36.php3",
"tabla1or2-37.php3", "tabla1or2-38.php3", "tabla1or2-39.php3",
"tabla1or2-40.php3", "tabla1or2-41.php3", "tabla1or2-42.php3",
"tabla1or2-43.php3", "tabla1or2-44.php3", "tabla1or2-45.php3",
"tabla1or2-46.php3", "tabla1or2-47.php3", "tabla1or2-48.php3",
"tabla1or2-49.php3", "tabla1or2-50.php3", "tabla1or2-51.php3",
"tabla1or2-52.php3", "tabla1or2-53.php3", "tabla1or2-54.php3",
"tabla1or2-55.php3", "tabla1or2-56.php3", "tabla1or2-57.php3",
"tabla1or2-58.php3", "tabla1or2-59.php3", "tabla1or2-60.php3",
"tabla1or2-61.php3", "tabla1or2-62.php3", "tabla1or2-63.php3",
"tabla1or2-64.php3", "tabla1or2-65.php3", "tabla1or2-66.php3",
"tabla1or2-67.php3", "tabla1or2-68.php3", "tabla1or2-69.php3",
"tabla1or2-70.php3", "tabla1or2-71.php3", "tabla1or2-72.php3",
"tabla1or2-73.php3", "tabla1or2-74.php3", "tabla1or2-75.php3",
"tabla1or2-76.php3", "tabla1or2-77.php3", "tabla1or2-78.php3",
"tabla2or1-1.php3", "tabla2or1-2.php3", "tabla2or1-3.php3",
"tabla2or1-4.php3", "tabla2or1-5.php3", "tabla2or1-6.php3",
"tabla2or1-7.php3", "tabla2or1-8.php3", "tabla2or1-9.php3",
"tabla2or1-10.php3", "tabla2or1-11.php3", "tabla2or1-12.php3",
"tabla2or1-13.php3", "tabla2or1-14.php3", "tabla2or1-15.php3",
"tabla2or1-16.php3", "tabla2or1-17.php3", "tabla2or1-18.php3",
"tabla2or1-19.php3", "tabla2or1-20.php3", "tabla2or1-21.php3",
"tabla2or1-22.php3", "tabla2or1-23.php3", "tabla2or1-24.php3",
"tabla2or1-25.php3", "tabla2or1-26.php3", "tabla2or1-27.php3",
"tabla2or1-28.php3", "tabla2or1-29.php3", "tabla2or1-30.php3",
"tabla2or1-31.php3", "tabla2or1-32.php3", "tabla2or1-33.php3",
"tabla2or1-34.php3", "tabla2or1-35.php3", "tabla2or1-36.php3",
"tabla2or1-37.php3", "tabla2or1-38.php3", "tabla2or1-39.php3",
"tabla2or1-40.php3", "tabla2or1-41.php3", "tabla2or1-42.php3",
"tabla2or1-43.php3", "tabla2or1-44.php3", "tabla2or1-45.php3",
"tabla2or1-46.php3", "tabla2or1-47.php3", "tabla2or1-48.php3",
"tabla2or1-49.php3", "tabla2or1-50.php3", "tabla2or1-51.php3",
"tabla2or1-52.php3", "tabla2or1-53.php3", "tabla2or1-54.php3",
"tabla2or1-55.php3", "tabla2or1-56.php3", "tabla2or1-57.php3",
"tabla2or1-58.php3", "tabla2or1-59.php3", "tabla2or1-60.php3",
"tabla2or1-61.php3", "tabla2or1-62.php3", "tabla2or1-63.php3",
"tabla2or1-64.php3", "tabla2or1-65.php3", "tabla2or1-66.php3",
"tabla2or1-67.php3", "tabla2or1-68.php3", "tabla2or1-69.php3",
"tabla2or1-70.php3", "tabla2or1-71.php3", "tabla2or1-72.php3",
"tabla2or1-73.php3", "tabla2or1-74.php3", "tabla2or1-75.php3",
"tabla2or1-76.php3", "tabla2or1-77.php3", "tabla2or1-78.php3",
"tabla2or1-79.php3", "tabla2or1-80.php3", "tabla2or1-81.php3",
"tabla2or1-82.php3", "tabla2or1-83.php3", "tabla2or1-84.php3",
"tabla2or1-85.php3", "tabla2or1-86.php3", "tabla2or1-87.php3",
"tabla2or1-88.php3", "tabla2or1-89.php3", "tabla2or1-90.php3",
"tabla2or1-91.php3", "tabla2or1-92.php3", "tabla2or1-93.php3",
"tabla2or1-94.php3", "tabla2or1-95.php3", "tabla2or1-96.php3",
"tabla2or1-97.php3", "tabla2or1-98.php3", "tabla2or1-99.php3",
"tabla2or1-100.php3", "tabla2or1-101.php3",
"tabla2or1-102.php3", "tabla2or1-103.php3",
"tabla2or1-104.php3", "tabla2or1-105.php3",
"tabla2or1-106.php3", "tabla2or1-107.php3", "tabla2or2-1.php3",
"tabla2or2-2.php3", "tabla2or2-4.php3", "tabla2or2-5.php3",
"tabla2or2-6.php3", "tabla2or2-7.php3", "tabla2or2-8.php3",
"tabla2or2-9.php3",  "tabla2or2-10.php3", "tabla2or2-11.php3",
"tabla2or2-12.php3", "tabla2or2-13.php3", "tabla2or2-14.php3",
"tabla2or2-15.php3",
"tabla2or2-16.php3", "tabla2or2-17.php3", "tabla2or2-18.php3",
"tabla2or2-19.php3", "tabla2or2-20.php3", "tabla2or2-21.php3",
"tabla2or2-22.php3", "tabla2or2-23.php3", "tabla2or2-24.php3",
"tabla2or2-25.php3", "tabla2or2-26.php3", "tabla2or2-27.php3",
"tabla2or2-28.php3", "tabla2or2-29.php3", "tabla2or2-30.php3",
"tabla2or2-31.php3", "tabla2or2-32.php3", "tabla2or2-33.php3",
"tabla2or2-35.php3", "tabla2or2-36.php3", "tabla2or2-37.php3",
"tabla2or2-38.php3", "tabla2or2-39.php3", "tabla2or2-41.php3",
"tabla2or2-42.php3", "tabla2or2-43.php3", "tabla2or2-44.php3",
"tabla2or2-45.php3", "tabla2or2-46.php3", "tabla2or2-47.php3",
"tabla2or2-48.php3", "tabla2or2-49.php3", "tabla2or2-50.php3",
"tabla2or2-51.php3", "tabla2or2-52.php3", "tabla2or2-53.php3",
"tabla2or2-54.php3", "tabla2or2-55.php3", "tabla2or2-56.php3",
"tabla2or2-57.php3", "tabla2or2-58.php3", "tabla2or2-59.php3",
"tabla2or2-60.php3", "tabla2or2-61.php3", "tabla2or2-62.php3",
"tabla2or2-63.php3", "tabla2or2-64.php3", "tabla2or2-65.php3",
"tabla2or2-66.php3", "tabla2or2-67.php3", "tabla2or2-68.php3",
"tabla2or2-69.php3", "tabla2or2-70.php3", "tabla2or2-71.php3",
"tabla2or2-72.php3", "tabla2or2-73.php3", "tabla2or2-74.php3",
"tabla2or2-75.php3", "tabla2or2-76.php3", "tabla2or2-77.php3",
"tabla2or2-78.php3", "tabla2or2-79.php3", "tabla2or2-80.php3",
"tabla2or2-81.php3", "tabla2or2-82.php3", "tabla2or2-83.php3",
"tabla2or2-84.php3", "tabla2or2-85.php3", "tabla2or2-86.php3",
"tabla2or2-87.php3", "tabla2or2-88.php3", "tabla2or2-89.php3",
"tabla2or2-90.php3", "tabla2or2-91.php3", "tabla2or2-92.php3",
"tabla2or2-93.php3", "tabla2or2-94.php3", "tabla2or2-95.php3",
"tabla2or2-96.php3", "tabla2or2-97.php3", "tabla2or2-98.php3",
"tabla2or2-99.php3", "tabla2or2-100.php3",
"tabla2or2-101.php3", "tabla2or2-102.php3",
"tabla2or2-103.php3", "tabla2or2-104.php3",
"tabla2or2-105.php3", "tabla2or2-106.php3",
"tabla2or2-107.php3", "tabla2or2-108.php3",
"tabla2or2-109.php3", "tabla2or2-110.php3",
"tabla2or2-111.php3", "tabla2or2-112.php3",
"tabla2or2-113.php3", "tabla2or2-114.php3",
"tabla2or2-115.php3", "tabla2or2-116.php3",
"tabla2or2-117.php3", "tabla2or2-118.php3",
"tabla2or2-119.php3", "tabla2or2-120.php3",
"tabla2or2-121.php3", "tabla2or2-122.php3",
"tabla2or2-123.php3", "tabla2or2-124.php3",
"tabla2or2-125.php3", "tabla2or2-126.php3",
"tabla2or2-127.php3", "tabla2or2-128.php3",
"tabla2or2-129.php3")
#
tabs61 <- sub(fls61, pattern=".php3", replacement="")
#
dontdo <- file.exists( paste(dir, tabs61, ".txt", sep="") )
workf <- fls61[dontdo=="FALSE"]
workt <- tabs61[dontdo=="FALSE"]
#
# WILL PROMPT ERROR IF ALL FILES ARE IN DISK (AS SHOULD BE THE CASE)
for (n in 1:length(workf)){
    direc<-paste(path,workf[n],sep="")
    url<-url(direc,open="r")
    tmp<-c("cacapunchis registro ",workt[n],readLines(url))
    close(url)
    filename<-paste(dir,workt[n],".txt",sep="")
    write.table(tmp, filename, sep="\t")
}
#
rm(workt, workf)

##################################################################################
##################################################################################
## EXTRACTS LIST WITH DATE, THEME VOTED, RESULT
##################################################################################
##################################################################################


N<-length(tabs58)
tmp <- rep(NA, times=N)
dat <- data.frame(fecha=tmp, favor=tmp, contra=tmp, absten=tmp, quorum=tmp, ausen=tmp, title=tmp)
## ALTERNATIVA all<-readLines("c:\\data\\fichas\\all.txt")

eric  #n <- 2
for (n in 1:N){
    filename<-paste(DipMex, "/matweb/tablas/58/",tabs58[n],".txt",sep="")
    tmp <- read.table(filename)
    tmp <- as.vector(tmp[,]) ## NO S� POR QU� TENGO QUE HACER ESTO PARA QUE EL OBJETO QUEDE COMO VECTOR
    tmp2 <- grep(tmp, pattern="nomtit")
    tmp3 <- sub(tmp[tmp2], pattern=".*VALUE=(.*)$", replacement="\\1")
    title <- sub(tmp3, pattern="\\Q\"\\E", replacement="")
    fecha <- sub(tmp[tmp2+1], pattern=".*<br> ([0-9]{1,2}/[0-9]{1,2}/[0-9]{2,4}).*", replacement="\\1")
    tmp2 <- grep(tmp, pattern="lola.11.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    favor <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    tmp2 <- grep(tmp, pattern="lola.12.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    contra <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    tmp2 <- grep(tmp, pattern="lola.13.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    absten <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    tmp2 <- grep(tmp, pattern="lola.14.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    quorum <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    tmp2 <- grep(tmp, pattern="lola.15.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    ausen <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    dat$title[n]  <- title
    dat$fecha[n]   <- fecha
    dat$favor[n]  <- favor
    dat$contra[n] <- contra
    dat$absten[n] <- absten
    dat$quorum[n] <- quorum
    dat$ausen[n]  <- ausen
              }
dat58 <- dat



N<-length(tabs57)
tmp <- rep(NA, times=N)
dat <- data.frame(fecha=tmp, favor=tmp, contra=tmp, absten=tmp, quorum=tmp, ausen=tmp, title=tmp)
## ALTERNATIVA all<-readLines("c:\\data\\fichas\\all.txt")

n <- 230
for (n in 1:N){
    filename<-paste(DipMex,"/matweb/tablas/57/",tabs57[n],".txt",sep="")
    tmp <- read.table(filename)
    tmp <- as.vector(tmp[,]) ## NO S� POR QU� TENGO QUE HACER ESTO PARA QUE EL OBJETO QUEDE COMO VECTOR
    tmp2 <- grep(tmp, pattern="nomtit")
    tmp3 <- sub(tmp[tmp2], pattern=".*VALUE=(.*)$", replacement="\\1")
    title <- sub(tmp3, pattern="\\Q\"\\E", replacement="")
    fecha <- sub(tmp[tmp2+1], pattern=".*<br> ([0-9]{1,2}/[0-9]{1,2}/[0-9]{2,4}).*", replacement="\\1")
    tmp2 <- grep(tmp, pattern="lola.11.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    favor <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    tmp2 <- grep(tmp, pattern="lola.12.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    contra <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    tmp2 <- grep(tmp, pattern="lola.13.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    absten <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    tmp2 <- grep(tmp, pattern="lola.14.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    quorum <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    tmp2 <- grep(tmp, pattern="lola.15.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    ausen <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    dat$title[n]  <- title
    dat$fecha[n]   <- fecha
    dat$favor[n]  <- favor
    dat$contra[n] <- contra
    dat$absten[n] <- absten
    dat$quorum[n] <- quorum
    dat$ausen[n]  <- ausen
              }
dat57 <- dat



N<-length(tabs59)
tmp <- rep(NA, times=N)
dat <- data.frame(fecha=tmp, favor=tmp, contra=tmp, absten=tmp, quorum=tmp, ausen=tmp, title=tmp)
## ALTERNATIVA all<-readLines("c:\\data\\fichas\\all.txt")

n <- 2
for (n in 1:N){
    filename<-paste(DipMex,"/matweb/tablas/59/",tabs59[n],".txt",sep="")
    tmp <- read.table(filename)
    tmp <- as.vector(tmp[,]) ## NO S� POR QU� TENGO QUE HACER ESTO PARA QUE EL OBJETO QUEDE COMO VECTOR
    tmp2 <- grep(tmp, pattern="nomtit")
    tmp3 <- sub(tmp[tmp2], pattern=".*VALUE=(.*)$", replacement="\\1")
    title <- sub(tmp3, pattern="\\Q\"\\E", replacement="")
    fecha <- sub(tmp[tmp2+1], pattern=".*<br> ([0-9]{1,2}/[0-9]{1,2}/[0-9]{2,4}).*", replacement="\\1")
    tmp2 <- grep(tmp, pattern="lola.11.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    favor <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    tmp2 <- grep(tmp, pattern="lola.12.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    contra <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    tmp2 <- grep(tmp, pattern="lola.13.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    absten <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    tmp2 <- grep(tmp, pattern="lola.14.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    quorum <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    tmp2 <- grep(tmp, pattern="lola.15.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    ausen <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    dat$title[n]  <- title
    dat$fecha[n]   <- fecha
    dat$favor[n]  <- favor
    dat$contra[n] <- contra
    dat$absten[n] <- absten
    dat$quorum[n] <- quorum
    dat$ausen[n]  <- ausen
              }
dat59 <- dat



N<-length(tabs60)
tmp <- rep(NA, times=N)
dat <- data.frame(fecha=tmp, favor=tmp, contra=tmp, absten=tmp, quorum=tmp, ausen=tmp, title=tmp)
## ALTERNATIVA all<-readLines("c:\\data\\fichas\\all.txt")

n <- 4
for (n in 1:N){
    filename<-paste(DipMex,"/matweb/tablas/60/",tabs60[n],".txt",sep="")
    tmp <- read.table(filename)
    tmp <- as.vector(tmp[,]) ## NO S� POR QU� TENGO QUE HACER ESTO PARA QUE EL OBJETO QUEDE COMO VECTOR
    tmp2 <- grep(tmp, pattern="nomtit")
    tmp3 <- sub(tmp[tmp2], pattern=".*VALUE=(.*)<p>.*$", replacement="\\1")
    title <- sub(tmp3, pattern="\\Q\"\\E", replacement="")
    tmp3 <- sub(tmp[tmp2], pattern=".*<p>(.*)>.*$", replacement="\\1")
    tmp3 <- sub(tmp3, pattern="^[ ]*", replacement="")
    tmp3 <- sub(tmp3, pattern="\\Q\"\\E", replacement="")
    tmp3 <- sub(tmp3, pattern=" de enero", replacement="/01/")
    tmp3 <- sub(tmp3, pattern=" de febrero", replacement="/02/")
    tmp3 <- sub(tmp3, pattern=" de marzo", replacement="/03/")
    tmp3 <- sub(tmp3, pattern=" de abril", replacement="/04/")
    tmp3 <- sub(tmp3, pattern=" de mayo", replacement="/05/")
    tmp3 <- sub(tmp3, pattern=" de junio", replacement="/06/")
    tmp3 <- sub(tmp3, pattern=" de julio", replacement="/07/")
    tmp3 <- sub(tmp3, pattern=" de agosto", replacement="/08/")
    tmp3 <- sub(tmp3, pattern=" de septiembre", replacement="/09/")
    tmp3 <- sub(tmp3, pattern=" de octubre", replacement="/10/")
    tmp3 <- sub(tmp3, pattern=" de noviembre", replacement="/11/")
    tmp3 <- sub(tmp3, pattern=" de diciembre", replacement="/12/")
    tmp3 <- sub(tmp3, pattern=" de ([0-9]{4})", replacement="\\1")
    fecha <- tmp3
    tmp2 <- grep(tmp, pattern="lola.11.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    favor <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    tmp2 <- grep(tmp, pattern="lola.12.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    contra <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    tmp2 <- grep(tmp, pattern="lola.13.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    absten <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    tmp2 <- grep(tmp, pattern="lola.14.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    quorum <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    tmp2 <- grep(tmp, pattern="lola.15.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    ausen <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    dat$title[n]  <- title
    dat$fecha[n]   <- fecha
    dat$favor[n]  <- favor
    dat$contra[n] <- contra
    dat$absten[n] <- absten
    dat$quorum[n] <- quorum
    dat$ausen[n]  <- ausen
              }
dat60 <- dat

N<-length(tabsrt)
tmp <- rep(NA, times=N)
dat <- data.frame(fecha=tmp, favor=tmp, contra=tmp, absten=tmp, quorum=tmp, ausen=tmp, title=tmp)
## ALTERNATIVA all<-readLines("c:\\data\\fichas\\all.txt")

#n <- 5
for (n in 1:N){
    filename<-paste(DipMex,"/matweb/tablas/root/",tabsrt[n],".txt",sep="")
    tmp <- read.table(filename)
    tmp <- as.vector(tmp[,]) ## NO S� POR QU� TENGO QUE HACER ESTO PARA QUE EL OBJETO QUEDE COMO VECTOR
    tmp2 <- grep(tmp, pattern="nomtit")
    tmp3 <- sub(tmp[tmp2], pattern=".*VALUE=(.*)$", replacement="\\1")
    title <- sub(tmp3, pattern="\\Q\"\\E", replacement="")
    fecha <- sub(tmp[tmp2+1], pattern=".*<br> ([0-9]{1,2}/[0-9]{1,2}/[0-9]{2,4}).*", replacement="\\1")
    tmp2 <- grep(tmp, pattern="lola.11.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    favor <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    tmp2 <- grep(tmp, pattern="lola.12.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    contra <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    tmp2 <- grep(tmp, pattern="lola.13.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    absten <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    tmp2 <- grep(tmp, pattern="lola.14.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    quorum <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    tmp2 <- grep(tmp, pattern="lola.15.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    ausen <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    dat$title[n]  <- title
    dat$fecha[n]   <- fecha
    dat$favor[n]  <- favor
    dat$contra[n] <- contra
    dat$absten[n] <- absten
    dat$quorum[n] <- quorum
    dat$ausen[n]  <- ausen
              }
## CORRECTS SOME ERROR BY HAND
for (n in 5:8){dat$fecha[n] <- "12/21/1999"}
## DROPS INFO-LESS RECORD
dat <- dat[-3,]
datrt <- dat

N<-length(tabs59bis)
tmp <- rep(NA, times=N)
dat <- data.frame(fecha=tmp, favor=tmp, contra=tmp, absten=tmp, quorum=tmp, ausen=tmp, title=tmp)
## ALTERNATIVA all<-readLines("c:\\data\\fichas\\all.txt")

#n <- 5
for (n in 1:N){
    filename<-paste(DipMex,"/matweb/tablas/59/",tabs59bis[n],".txt",sep="")
    tmp <- read.table(filename)
    tmp <- as.vector(tmp[,]) ## NO S� POR QU� TENGO QUE HACER ESTO PARA QUE EL OBJETO QUEDE COMO VECTOR
    tmp2 <- grep(tmp, pattern="nomtit")
    tmp3 <- sub(tmp[tmp2], pattern=".*VALUE=(.*)$", replacement="\\1")
    title <- sub(tmp3, pattern="\\Q\"\\E", replacement="")
    fecha <- sub(tmp[tmp2+1], pattern=".*<br> ([0-9]{1,2}/[0-9]{1,2}/[0-9]{2,4}).*", replacement="\\1")
    tmp2 <- grep(tmp, pattern="lola.11.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    favor <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    tmp2 <- grep(tmp, pattern="lola.12.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    contra <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    tmp2 <- grep(tmp, pattern="lola.13.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    absten <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    tmp2 <- grep(tmp, pattern="lola.14.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    quorum <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    tmp2 <- grep(tmp, pattern="lola.15.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    ausen <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    dat$title[n]  <- title
    dat$fecha[n]   <- fecha
    dat$favor[n]  <- favor
    dat$contra[n] <- contra
    dat$absten[n] <- absten
    dat$quorum[n] <- quorum
    dat$ausen[n]  <- ausen
              }
dat59bis <- dat


N<-length(tabs61)
tmp <- rep(NA, times=N)
dat <- data.frame(fecha=tmp, favor=tmp, contra=tmp, absten=tmp, quorum=tmp, ausen=tmp, title=tmp)
## ALTERNATIVA all<-readLines("c:\\data\\fichas\\all.txt")

n <- 4
for (n in 1:N){
    filename<-paste(DipMex,"/matweb/tablas/61/",tabs61[n],".txt",sep="")
    tmp <- read.table(filename)
    tmp <- as.vector(tmp[,]) ## NO S� POR QU� TENGO QUE HACER ESTO PARA QUE EL OBJETO QUEDE COMO VECTOR
    tmp2 <- grep(tmp, pattern="nomtit")
    tmp3 <- sub(tmp[tmp2], pattern=".*VALUE=(.*)<p>.*$", replacement="\\1")
    title <- sub(tmp3, pattern="\\Q\"\\E", replacement="")
    tmp3 <- sub(tmp[tmp2], pattern=".*<p>(.*)>.*$", replacement="\\1")
    tmp3 <- sub(tmp3, pattern="^[ ]*", replacement="")
    tmp3 <- sub(tmp3, pattern="\\Q\"\\E", replacement="")
    tmp3 <- sub(tmp3, pattern=" de enero", replacement="/01/")
    tmp3 <- sub(tmp3, pattern=" de febrero", replacement="/02/")
    tmp3 <- sub(tmp3, pattern=" de marzo", replacement="/03/")
    tmp3 <- sub(tmp3, pattern=" de abril", replacement="/04/")
    tmp3 <- sub(tmp3, pattern=" de mayo", replacement="/05/")
    tmp3 <- sub(tmp3, pattern=" de junio", replacement="/06/")
    tmp3 <- sub(tmp3, pattern=" de julio", replacement="/07/")
    tmp3 <- sub(tmp3, pattern=" de agosto", replacement="/08/")
    tmp3 <- sub(tmp3, pattern=" de septiembre", replacement="/09/")
    tmp3 <- sub(tmp3, pattern=" de octubre", replacement="/10/")
    tmp3 <- sub(tmp3, pattern=" de noviembre", replacement="/11/")
    tmp3 <- sub(tmp3, pattern=" de diciembre", replacement="/12/")
    tmp3 <- sub(tmp3, pattern=" de ([0-9]{4})", replacement="\\1")
    fecha <- tmp3
    tmp2 <- grep(tmp, pattern="lola.11.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    favor <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    tmp2 <- grep(tmp, pattern="lola.12.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    contra <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    tmp2 <- grep(tmp, pattern="lola.13.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    absten <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    tmp2 <- grep(tmp, pattern="lola.14.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    quorum <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    tmp2 <- grep(tmp, pattern="lola.15.")
    if (length(tmp2)==0) tmp3 <- 0 else tmp3 <- sub(tmp[tmp2], pattern=".*value=(.*)>.*", replacement="\\1")
    ausen <- as.numeric(gsub(tmp3, pattern="[^0-9]", replacement=""))
    dat$title[n]  <- title
    dat$fecha[n]   <- fecha
    dat$favor[n]  <- favor
    dat$contra[n] <- contra
    dat$absten[n] <- absten
    dat$quorum[n] <- quorum
    dat$ausen[n]  <- ausen
              }
dat61 <- dat

## CONSOLIDATES
dat57$leg <- 57; dat58$leg <- 58; dat59$leg <- 59; dat60$leg <- 60; datrt$leg <- -1; dat59bis$leg <- 59; dat61$leg <- 61;
dat57$filename <- tabs57; dat58$filename <- tabs58; dat59$filename <- tabs59; dat60$filename <- tabs60; datrt$filename <- tabsrt[-3]; dat59bis$filename <- tabs59bis; dat61$filename <- tabs61
dat <- rbind(dat58, dat57, dat59, dat60, datrt, dat59bis, dat61)
#
tmp <- dat
tmp$yr <- rep(NA,times=dim(tmp)[1]); tmp$mo <- rep(NA,times=dim(tmp)[1]); tmp$dy <- rep(NA,times=dim(tmp)[1])
#n <-1
for (n in 1:dim(tmp)[1]){
    tmp$yr[n] <- sub(tmp$fecha[n], pattern="[0-9]{1,2}/[0-9]{1,2}/([0-9]{2,4})", replacement="\\1")
    tmp$dy[n] <- sub(tmp$fecha[n], pattern="[0-9]{1,2}/([0-9]{1,2})/[0-9]{2,4}", replacement="\\1")
    tmp$mo[n] <- sub(tmp$fecha[n], pattern="([0-9]{1,2})/[0-9]{1,2}/[0-9]{2,4}", replacement="\\1")
    }
# MO DY INVERTED FOR LEG=60:61
tmp2 <- tmp$mo
tmp3 <- tmp$dy
tmp$mo[tmp$leg==60] <- tmp3[tmp$leg==60]
tmp$dy[tmp$leg==60] <- tmp2[tmp$leg==60]
tmp$mo[tmp$leg==61] <- tmp3[tmp$leg==61]
tmp$dy[tmp$leg==61] <- tmp2[tmp$leg==61]
tmp$yr[tmp$yr==2098] <- 1998
dat <- tmp

# QUITA LOS VOTOS EN ROOT, TODOS PARECEN REDUNDANTES
tmp <- dat[dat$leg>0,]
dat <- tmp

# CLEANS TEXT
tmp <- dat$title
tmp <- gsub(tmp, pattern="&aacute;", replacement="�")
tmp <- gsub(tmp, pattern="&eacute;", replacement="�")
tmp <- gsub(tmp, pattern="&iacute;", replacement="�")
tmp <- gsub(tmp, pattern="&oacute;", replacement="�")
tmp <- gsub(tmp, pattern="&uacute;", replacement="�")
tmp <- gsub(tmp, pattern="&ntilde;", replacement="�")
tmp <- gsub(tmp, pattern="&uuml;", replacement="�")
tmp <- gsub(tmp, pattern="&ardm;", replacement="a")
tmp <- gsub(tmp, pattern="&ordm;", replacement="o")
tmp <- gsub(tmp, pattern="&deg;", replacement="")
tmp <- gsub(tmp, pattern="\\Q\"\\E", replacement="")
tmp2 <- grep(tmp, pattern="\\Q\"\\E")
#tmp2
#tmp[tmp2]
dat$title <- tmp

# EXPORT VOTES FOUND
write.table(dat, file="votes57-61.xls", sep=",")

save.image(paste(DipMex,"/voTabs.RData",sep=""))

###########################################
####  COMPARE DAT WITH CANT�DESPOSATO  ####
###########################################
#
cd <- read.csv (paste(DipMex,"/cantudespo/description.csv",sep=""))
load(paste(DipMex,"/voTabs.RData",sep=""))
#
dat$yr <- as.numeric(dat$yr) ## OJO: LA VERSION QUE MAND� 8MAY11 A CANTU Y DESPOSATO LO DEJABA COMO CHARACTER, LO QUE CAMBIA EL SORT ORDER Y PLT EL FOLIO
dat$mo <- as.numeric(dat$mo)
dat$dy <- as.numeric(dat$dy)
#
## FINDS/REMOVES DUPLICATES IN MY DATA
dat$ord <- 1:dim(dat)[1]
tmp<-dat[order(dat$title, dat$favor, dat$contra, dat$absten, dat$yr, dat$mo, dat$dy),]
dupli <- rep(0, times=dim(dat)[1])
for (n in 2:length(dupli)){
    dupli[n] <- ifelse (tmp$title[n]==tmp$title[n-1] & tmp$favor[n]==tmp$favor[n-1] & tmp$contra[n]==tmp$contra[n-1] &
    tmp$absten[n]==tmp$absten[n-1] & tmp$yr[n]==tmp$yr[n-1] & tmp$mo[n]==tmp$mo[n-1] & tmp$dy[n]==tmp$dy[n-1], 1, 0)
    }
tmp$dupli <- dupli
tmp$ord[dupli==1] #duplicates ## IDENTICAL BUT WITH A TABLE EACH... WHY ARE THEY PLACED TWICE IN DIRECTORIES?
tmp <- tmp[dupli==0,] ## DROPS DUPLICATE OBSERVATIONS
tmp <- tmp[order(tmp$yr, tmp$mo, tmp$dy, tmp$ord),] # SORTS CHRONOLOGICALLY
tmp <- tmp[,-13] # drops dupli
tmp <- tmp[,-13] # drops ord
#
mine <- tmp
theirs <- cd
#
## ADDS FOLIO TO MY DATA
mine$folio <- 1:dim(mine)[1]
#
# rename their vars
names(theirs)[names(theirs)=="legislature_number"] = "leg"
names(theirs)[names(theirs)=="period_name"] = "period"
names(theirs)[names(theirs)=="vote_description"] = "title"
#
theirs$yr <- as.numeric (gsub(theirs$vote_date, pattern="([0-9]{4})-([0-9]{2})-([0-9]{2})", replacement="\\1"))
theirs$mo <- as.numeric (gsub(theirs$vote_date, pattern="([0-9]{4})-([0-9]{2})-([0-9]{2})", replacement="\\2"))
theirs$dy <- as.numeric (gsub(theirs$vote_date, pattern="([0-9]{4})-([0-9]{2})-([0-9]{2})", replacement="\\3"))
#
mine$yr <- as.numeric(mine$yr)
mine$mo <- as.numeric(mine$mo)
mine$dy <- as.numeric(mine$dy)
#
###REMOVE PATENTHESES AND OTHER CHARACTERS THAT CAUSE PROBLEMS IN GSUB
tmp <- rep(NA, times=length(theirs$title))
for (n in 1:length(tmp)){
    tmp[n] <- gsub(theirs$title[n], pattern="\\Q(\\E", replacement="")
    tmp[n] <- gsub(tmp[n], pattern="\\Q)\\E", replacement="")
    tmp[n] <- gsub(tmp[n], pattern="\\Q[\\E", replacement="")
    tmp[n] <- gsub(tmp[n], pattern="\\Q]\\E", replacement="")
    tmp[n] <- gsub(tmp[n], pattern="\\Q$\\E", replacement="")
    tmp[n] <- gsub(tmp[n], pattern="\\Q�\\E", replacement="")
    tmp[n] <- gsub(tmp[n], pattern="\\Q�\\E", replacement="")
    tmp[n] <- gsub(tmp[n], pattern="([1-9])o", replacement="\\1")
    }
theirs$title <- tmp
tmp <- rep(NA, times=length(mine$title))
for (n in 1:length(tmp)){
    tmp[n] <- gsub(mine$title[n], pattern="\\Q(\\E", replacement="")
    tmp[n] <- gsub(tmp[n], pattern="\\Q)\\E", replacement="")
    tmp[n] <- gsub(tmp[n], pattern="\\Q[\\E", replacement="")
    tmp[n] <- gsub(tmp[n], pattern="\\Q]\\E", replacement="")
    tmp[n] <- gsub(tmp[n], pattern="\\Q$\\E", replacement="")
    tmp[n] <- gsub(tmp[n], pattern="\\Q�\\E", replacement="")
    tmp[n] <- gsub(tmp[n], pattern="\\Q�\\E", replacement="")
    tmp[n] <- gsub(tmp[n], pattern="([1-9])o", replacement="\\1")
    }
mine$title <- tmp
#
nMatches <- rep(0, times=length(theirs$VID))
match <- data.frame(VID=rep(0, times=length(theirs$VID)), folio=rep(0, times=length(theirs$VID)))
mine$VID <- rep(0, times=dim(mine)[1])
#
for (nt in c(1:length(theirs$VID))){
    nm <- grep(mine$title, pattern=theirs$title[nt])
    nMatches[nt] <- length(nm)
    match[nt,1] <- ifelse (length(nm)==1, nt, 0)
    match[nt,2] <- ifelse (length(nm)==1, nm, 0)
#    mine$VID[nm] <- ifelse (length(nm)==1, theirs$VID[nt], 0)
    }
two <- array(NA, dim=c(2,8,table(nMatches==2)[2]))
colnames(two) <- c("VID","folio","yr","mo","fav","con","abs", "match")
tmp <- theirs$VID[nMatches==2]
for (nt in 1:length(tmp)){
    nm <- grep(mine$title, pattern=theirs$title[tmp[nt]])
    two[,1,nt] <- rep(tmp[nt], times=2) # VID
    two[,2,nt] <- nm                    # folio
    two[1,3,nt] <- mine$yr[nm[1]]-theirs$yr[tmp[nt]]
    two[2,3,nt] <- mine$yr[nm[2]]-theirs$yr[tmp[nt]]
    two[1,4,nt] <- mine$mo[nm[1]]-theirs$mo[tmp[nt]]
    two[2,4,nt] <- mine$mo[nm[2]]-theirs$mo[tmp[nt]]
    two[1,5,nt] <- mine$favor[nm[1]]-theirs$yea[tmp[nt]]
    two[2,5,nt] <- mine$favor[nm[2]]-theirs$yea[tmp[nt]]
    two[1,6,nt] <- mine$contra[nm[1]]-theirs$nay[tmp[nt]]
    two[2,6,nt] <- mine$contra[nm[2]]-theirs$nay[tmp[nt]]
    two[1,7,nt] <- mine$absten[nm[1]]-theirs$abs[tmp[nt]]
    two[2,7,nt] <- mine$absten[nm[2]]-theirs$abs[tmp[nt]]
    }
three <- array(NA, dim=c(3,8,table(nMatches==3)[2]))
colnames(three) <- c("VID","folio","yr","mo","fav","con","abs", "match")
tmp <- theirs$VID[nMatches==3]
for (nt in 1:length(tmp)){
    nm <- grep(mine$title, pattern=theirs$title[tmp[nt]])
    three[,1,nt] <- rep(tmp[nt], times=3) # VID
    three[,2,nt] <- nm                    # folio
    three[1,3,nt] <- mine$yr[nm[1]]-theirs$yr[tmp[nt]]
    three[2,3,nt] <- mine$yr[nm[2]]-theirs$yr[tmp[nt]]
    three[3,3,nt] <- mine$yr[nm[3]]-theirs$yr[tmp[nt]]
    three[1,4,nt] <- mine$mo[nm[1]]-theirs$mo[tmp[nt]]
    three[2,4,nt] <- mine$mo[nm[2]]-theirs$mo[tmp[nt]]
    three[3,4,nt] <- mine$mo[nm[3]]-theirs$mo[tmp[nt]]
    three[1,5,nt] <- mine$favor[nm[1]]-theirs$yea[tmp[nt]]
    three[2,5,nt] <- mine$favor[nm[2]]-theirs$yea[tmp[nt]]
    three[3,5,nt] <- mine$favor[nm[3]]-theirs$yea[tmp[nt]]
    three[1,6,nt] <- mine$contra[nm[1]]-theirs$nay[tmp[nt]]
    three[2,6,nt] <- mine$contra[nm[2]]-theirs$nay[tmp[nt]]
    three[3,6,nt] <- mine$contra[nm[3]]-theirs$nay[tmp[nt]]
    three[1,7,nt] <- mine$absten[nm[1]]-theirs$abs[tmp[nt]]
    three[2,7,nt] <- mine$absten[nm[2]]-theirs$abs[tmp[nt]]
    three[3,7,nt] <- mine$absten[nm[3]]-theirs$abs[tmp[nt]]
    }
four <- array(NA, dim=c(4,8,table(nMatches==4)[2]))
colnames(four) <- c("VID","folio","yr","mo","fav","con","abs", "match")
tmp <- theirs$VID[nMatches==4]
for (nt in 1:length(tmp)){
    nm <- grep(mine$title, pattern=theirs$title[tmp[nt]])
    four[,1,nt] <- rep(tmp[nt], times=4) # VID
    four[,2,nt] <- nm                    # folio
    four[1,3,nt] <- mine$yr[nm[1]]-theirs$yr[tmp[nt]]
    four[2,3,nt] <- mine$yr[nm[2]]-theirs$yr[tmp[nt]]
    four[3,3,nt] <- mine$yr[nm[3]]-theirs$yr[tmp[nt]]
    four[4,3,nt] <- mine$yr[nm[4]]-theirs$yr[tmp[nt]]
    four[1,4,nt] <- mine$mo[nm[1]]-theirs$mo[tmp[nt]]
    four[2,4,nt] <- mine$mo[nm[2]]-theirs$mo[tmp[nt]]
    four[3,4,nt] <- mine$mo[nm[3]]-theirs$mo[tmp[nt]]
    four[4,4,nt] <- mine$mo[nm[4]]-theirs$mo[tmp[nt]]
    four[1,5,nt] <- mine$favor[nm[1]]-theirs$yea[tmp[nt]]
    four[2,5,nt] <- mine$favor[nm[2]]-theirs$yea[tmp[nt]]
    four[3,5,nt] <- mine$favor[nm[3]]-theirs$yea[tmp[nt]]
    four[4,5,nt] <- mine$favor[nm[4]]-theirs$yea[tmp[nt]]
    four[1,6,nt] <- mine$contra[nm[1]]-theirs$nay[tmp[nt]]
    four[2,6,nt] <- mine$contra[nm[2]]-theirs$nay[tmp[nt]]
    four[3,6,nt] <- mine$contra[nm[3]]-theirs$nay[tmp[nt]]
    four[4,6,nt] <- mine$contra[nm[4]]-theirs$nay[tmp[nt]]
    four[1,7,nt] <- mine$absten[nm[1]]-theirs$abs[tmp[nt]]
    four[2,7,nt] <- mine$absten[nm[2]]-theirs$abs[tmp[nt]]
    four[3,7,nt] <- mine$absten[nm[3]]-theirs$abs[tmp[nt]]
    four[4,7,nt] <- mine$absten[nm[4]]-theirs$abs[tmp[nt]]
    }
five <- array(NA, dim=c(5,8,table(nMatches==5)[2]))
colnames(five) <- c("VID","folio","yr","mo","fav","con","abs", "match")
tmp <- theirs$VID[nMatches==5]
for (nt in 1:length(tmp)){
    nm <- grep(mine$title, pattern=theirs$title[tmp[nt]])
    five[,1,nt] <- rep(tmp[nt], times=5) # VID
    five[,2,nt] <- nm                    # folio
    five[1,3,nt] <- mine$yr[nm[1]]-theirs$yr[tmp[nt]]
    five[2,3,nt] <- mine$yr[nm[2]]-theirs$yr[tmp[nt]]
    five[3,3,nt] <- mine$yr[nm[3]]-theirs$yr[tmp[nt]]
    five[4,3,nt] <- mine$yr[nm[4]]-theirs$yr[tmp[nt]]
    five[5,3,nt] <- mine$yr[nm[5]]-theirs$yr[tmp[nt]]
    five[1,4,nt] <- mine$mo[nm[1]]-theirs$mo[tmp[nt]]
    five[2,4,nt] <- mine$mo[nm[2]]-theirs$mo[tmp[nt]]
    five[3,4,nt] <- mine$mo[nm[3]]-theirs$mo[tmp[nt]]
    five[4,4,nt] <- mine$mo[nm[4]]-theirs$mo[tmp[nt]]
    five[5,4,nt] <- mine$mo[nm[5]]-theirs$mo[tmp[nt]]
    five[1,5,nt] <- mine$favor[nm[1]]-theirs$yea[tmp[nt]]
    five[2,5,nt] <- mine$favor[nm[2]]-theirs$yea[tmp[nt]]
    five[3,5,nt] <- mine$favor[nm[3]]-theirs$yea[tmp[nt]]
    five[4,5,nt] <- mine$favor[nm[4]]-theirs$yea[tmp[nt]]
    five[5,5,nt] <- mine$favor[nm[5]]-theirs$yea[tmp[nt]]
    five[1,6,nt] <- mine$contra[nm[1]]-theirs$nay[tmp[nt]]
    five[2,6,nt] <- mine$contra[nm[2]]-theirs$nay[tmp[nt]]
    five[3,6,nt] <- mine$contra[nm[3]]-theirs$nay[tmp[nt]]
    five[4,6,nt] <- mine$contra[nm[4]]-theirs$nay[tmp[nt]]
    five[5,6,nt] <- mine$contra[nm[5]]-theirs$nay[tmp[nt]]
    five[1,7,nt] <- mine$absten[nm[1]]-theirs$abs[tmp[nt]]
    five[2,7,nt] <- mine$absten[nm[2]]-theirs$abs[tmp[nt]]
    five[3,7,nt] <- mine$absten[nm[3]]-theirs$abs[tmp[nt]]
    five[4,7,nt] <- mine$absten[nm[4]]-theirs$abs[tmp[nt]]
    five[5,7,nt] <- mine$absten[nm[5]]-theirs$abs[tmp[nt]]
    }
six <- array(NA, dim=c(6,8,table(nMatches==6)[2]))
colnames(six) <- c("VID","folio","yr","mo","fav","con","abs", "match")
tmp <- theirs$VID[nMatches==6]
for (nt in 1:length(tmp)){
    nm <- grep(mine$title, pattern=theirs$title[tmp[nt]])
    six[,1,nt] <- rep(tmp[nt], times=6) # VID
    six[,2,nt] <- nm                    # folio
    six[1,3,nt] <- mine$yr[nm[1]]-theirs$yr[tmp[nt]]
    six[2,3,nt] <- mine$yr[nm[2]]-theirs$yr[tmp[nt]]
    six[3,3,nt] <- mine$yr[nm[3]]-theirs$yr[tmp[nt]]
    six[4,3,nt] <- mine$yr[nm[4]]-theirs$yr[tmp[nt]]
    six[5,3,nt] <- mine$yr[nm[5]]-theirs$yr[tmp[nt]]
    six[6,3,nt] <- mine$yr[nm[6]]-theirs$yr[tmp[nt]]
    six[1,4,nt] <- mine$mo[nm[1]]-theirs$mo[tmp[nt]]
    six[2,4,nt] <- mine$mo[nm[2]]-theirs$mo[tmp[nt]]
    six[3,4,nt] <- mine$mo[nm[3]]-theirs$mo[tmp[nt]]
    six[4,4,nt] <- mine$mo[nm[4]]-theirs$mo[tmp[nt]]
    six[5,4,nt] <- mine$mo[nm[5]]-theirs$mo[tmp[nt]]
    six[6,4,nt] <- mine$mo[nm[6]]-theirs$mo[tmp[nt]]
    six[1,5,nt] <- mine$favor[nm[1]]-theirs$yea[tmp[nt]]
    six[2,5,nt] <- mine$favor[nm[2]]-theirs$yea[tmp[nt]]
    six[3,5,nt] <- mine$favor[nm[3]]-theirs$yea[tmp[nt]]
    six[4,5,nt] <- mine$favor[nm[4]]-theirs$yea[tmp[nt]]
    six[5,5,nt] <- mine$favor[nm[5]]-theirs$yea[tmp[nt]]
    six[6,5,nt] <- mine$favor[nm[6]]-theirs$yea[tmp[nt]]
    six[1,6,nt] <- mine$contra[nm[1]]-theirs$nay[tmp[nt]]
    six[2,6,nt] <- mine$contra[nm[2]]-theirs$nay[tmp[nt]]
    six[3,6,nt] <- mine$contra[nm[3]]-theirs$nay[tmp[nt]]
    six[4,6,nt] <- mine$contra[nm[4]]-theirs$nay[tmp[nt]]
    six[5,6,nt] <- mine$contra[nm[5]]-theirs$nay[tmp[nt]]
    six[6,6,nt] <- mine$contra[nm[6]]-theirs$nay[tmp[nt]]
    six[1,7,nt] <- mine$absten[nm[1]]-theirs$abs[tmp[nt]]
    six[2,7,nt] <- mine$absten[nm[2]]-theirs$abs[tmp[nt]]
    six[3,7,nt] <- mine$absten[nm[3]]-theirs$abs[tmp[nt]]
    six[4,7,nt] <- mine$absten[nm[4]]-theirs$abs[tmp[nt]]
    six[5,7,nt] <- mine$absten[nm[5]]-theirs$abs[tmp[nt]]
    six[6,7,nt] <- mine$absten[nm[6]]-theirs$abs[tmp[nt]]
    }
seven <- array(NA, dim=c(7,8,table(nMatches==7)[2]))
colnames(seven) <- c("VID","folio","yr","mo","fav","con","abs", "match")
tmp <- theirs$VID[nMatches==7]
for (nt in 1:length(tmp)){
    nm <- grep(mine$title, pattern=theirs$title[tmp[nt]])
    seven[,1,nt] <- rep(tmp[nt], times=7) # VID
    seven[,2,nt] <- nm                    # folio
    seven[1,3,nt] <- mine$yr[nm[1]]-theirs$yr[tmp[nt]]
    seven[2,3,nt] <- mine$yr[nm[2]]-theirs$yr[tmp[nt]]
    seven[3,3,nt] <- mine$yr[nm[3]]-theirs$yr[tmp[nt]]
    seven[4,3,nt] <- mine$yr[nm[4]]-theirs$yr[tmp[nt]]
    seven[5,3,nt] <- mine$yr[nm[5]]-theirs$yr[tmp[nt]]
    seven[6,3,nt] <- mine$yr[nm[6]]-theirs$yr[tmp[nt]]
    seven[7,3,nt] <- mine$yr[nm[7]]-theirs$yr[tmp[nt]]
    seven[1,4,nt] <- mine$mo[nm[1]]-theirs$mo[tmp[nt]]
    seven[2,4,nt] <- mine$mo[nm[2]]-theirs$mo[tmp[nt]]
    seven[3,4,nt] <- mine$mo[nm[3]]-theirs$mo[tmp[nt]]
    seven[4,4,nt] <- mine$mo[nm[4]]-theirs$mo[tmp[nt]]
    seven[5,4,nt] <- mine$mo[nm[5]]-theirs$mo[tmp[nt]]
    seven[6,4,nt] <- mine$mo[nm[6]]-theirs$mo[tmp[nt]]
    seven[7,4,nt] <- mine$mo[nm[7]]-theirs$mo[tmp[nt]]
    seven[1,5,nt] <- mine$favor[nm[1]]-theirs$yea[tmp[nt]]
    seven[2,5,nt] <- mine$favor[nm[2]]-theirs$yea[tmp[nt]]
    seven[3,5,nt] <- mine$favor[nm[3]]-theirs$yea[tmp[nt]]
    seven[4,5,nt] <- mine$favor[nm[4]]-theirs$yea[tmp[nt]]
    seven[5,5,nt] <- mine$favor[nm[5]]-theirs$yea[tmp[nt]]
    seven[6,5,nt] <- mine$favor[nm[6]]-theirs$yea[tmp[nt]]
    seven[7,5,nt] <- mine$favor[nm[7]]-theirs$yea[tmp[nt]]
    seven[1,6,nt] <- mine$contra[nm[1]]-theirs$nay[tmp[nt]]
    seven[2,6,nt] <- mine$contra[nm[2]]-theirs$nay[tmp[nt]]
    seven[3,6,nt] <- mine$contra[nm[3]]-theirs$nay[tmp[nt]]
    seven[4,6,nt] <- mine$contra[nm[4]]-theirs$nay[tmp[nt]]
    seven[5,6,nt] <- mine$contra[nm[5]]-theirs$nay[tmp[nt]]
    seven[6,6,nt] <- mine$contra[nm[6]]-theirs$nay[tmp[nt]]
    seven[7,6,nt] <- mine$contra[nm[7]]-theirs$nay[tmp[nt]]
    seven[1,7,nt] <- mine$absten[nm[1]]-theirs$abs[tmp[nt]]
    seven[2,7,nt] <- mine$absten[nm[2]]-theirs$abs[tmp[nt]]
    seven[3,7,nt] <- mine$absten[nm[3]]-theirs$abs[tmp[nt]]
    seven[4,7,nt] <- mine$absten[nm[4]]-theirs$abs[tmp[nt]]
    seven[5,7,nt] <- mine$absten[nm[5]]-theirs$abs[tmp[nt]]
    seven[6,7,nt] <- mine$absten[nm[6]]-theirs$abs[tmp[nt]]
    seven[7,7,nt] <- mine$absten[nm[7]]-theirs$abs[tmp[nt]]
    }
eight <- array(NA, dim=c(8,8,table(nMatches==8)[2]))
colnames(eight) <- c("VID","folio","yr","mo","fav","con","abs", "match")
tmp <- theirs$VID[nMatches==8]
for (nt in 1:length(tmp)){
    nm <- grep(mine$title, pattern=theirs$title[tmp[nt]])
    eight[,1,nt] <- rep(tmp[nt], times=8) # VID
    eight[,2,nt] <- nm                    # folio
    eight[1,3,nt] <- mine$yr[nm[1]]-theirs$yr[tmp[nt]]
    eight[2,3,nt] <- mine$yr[nm[2]]-theirs$yr[tmp[nt]]
    eight[3,3,nt] <- mine$yr[nm[3]]-theirs$yr[tmp[nt]]
    eight[4,3,nt] <- mine$yr[nm[4]]-theirs$yr[tmp[nt]]
    eight[5,3,nt] <- mine$yr[nm[5]]-theirs$yr[tmp[nt]]
    eight[6,3,nt] <- mine$yr[nm[6]]-theirs$yr[tmp[nt]]
    eight[7,3,nt] <- mine$yr[nm[7]]-theirs$yr[tmp[nt]]
    eight[8,3,nt] <- mine$yr[nm[8]]-theirs$yr[tmp[nt]]
    eight[1,4,nt] <- mine$mo[nm[1]]-theirs$mo[tmp[nt]]
    eight[2,4,nt] <- mine$mo[nm[2]]-theirs$mo[tmp[nt]]
    eight[3,4,nt] <- mine$mo[nm[3]]-theirs$mo[tmp[nt]]
    eight[4,4,nt] <- mine$mo[nm[4]]-theirs$mo[tmp[nt]]
    eight[5,4,nt] <- mine$mo[nm[5]]-theirs$mo[tmp[nt]]
    eight[6,4,nt] <- mine$mo[nm[6]]-theirs$mo[tmp[nt]]
    eight[7,4,nt] <- mine$mo[nm[7]]-theirs$mo[tmp[nt]]
    eight[8,4,nt] <- mine$mo[nm[8]]-theirs$mo[tmp[nt]]
    eight[1,5,nt] <- mine$favor[nm[1]]-theirs$yea[tmp[nt]]
    eight[2,5,nt] <- mine$favor[nm[2]]-theirs$yea[tmp[nt]]
    eight[3,5,nt] <- mine$favor[nm[3]]-theirs$yea[tmp[nt]]
    eight[4,5,nt] <- mine$favor[nm[4]]-theirs$yea[tmp[nt]]
    eight[5,5,nt] <- mine$favor[nm[5]]-theirs$yea[tmp[nt]]
    eight[6,5,nt] <- mine$favor[nm[6]]-theirs$yea[tmp[nt]]
    eight[7,5,nt] <- mine$favor[nm[7]]-theirs$yea[tmp[nt]]
    eight[8,5,nt] <- mine$favor[nm[8]]-theirs$yea[tmp[nt]]
    eight[1,6,nt] <- mine$contra[nm[1]]-theirs$nay[tmp[nt]]
    eight[2,6,nt] <- mine$contra[nm[2]]-theirs$nay[tmp[nt]]
    eight[3,6,nt] <- mine$contra[nm[3]]-theirs$nay[tmp[nt]]
    eight[4,6,nt] <- mine$contra[nm[4]]-theirs$nay[tmp[nt]]
    eight[5,6,nt] <- mine$contra[nm[5]]-theirs$nay[tmp[nt]]
    eight[6,6,nt] <- mine$contra[nm[6]]-theirs$nay[tmp[nt]]
    eight[7,6,nt] <- mine$contra[nm[7]]-theirs$nay[tmp[nt]]
    eight[8,6,nt] <- mine$contra[nm[8]]-theirs$nay[tmp[nt]]
    eight[1,7,nt] <- mine$absten[nm[1]]-theirs$abs[tmp[nt]]
    eight[2,7,nt] <- mine$absten[nm[2]]-theirs$abs[tmp[nt]]
    eight[3,7,nt] <- mine$absten[nm[3]]-theirs$abs[tmp[nt]]
    eight[4,7,nt] <- mine$absten[nm[4]]-theirs$abs[tmp[nt]]
    eight[5,7,nt] <- mine$absten[nm[5]]-theirs$abs[tmp[nt]]
    eight[6,7,nt] <- mine$absten[nm[6]]-theirs$abs[tmp[nt]]
    eight[7,7,nt] <- mine$absten[nm[7]]-theirs$abs[tmp[nt]]
    eight[8,7,nt] <- mine$absten[nm[8]]-theirs$abs[tmp[nt]]
    }
nine <- array(NA, dim=c(9,8,table(nMatches==9)[2]))
colnames(nine) <- c("VID","folio","yr","mo","fav","con","abs", "match")
tmp <- theirs$VID[nMatches==9]
for (nt in 1:length(tmp)){
    nm <- grep(mine$title, pattern=theirs$title[tmp[nt]])
    nine[,1,nt] <- rep(tmp[nt], times=9) # VID
    nine[,2,nt] <- nm                    # folio
    nine[1,3,nt] <- mine$yr[nm[1]]-theirs$yr[tmp[nt]]
    nine[2,3,nt] <- mine$yr[nm[2]]-theirs$yr[tmp[nt]]
    nine[3,3,nt] <- mine$yr[nm[3]]-theirs$yr[tmp[nt]]
    nine[4,3,nt] <- mine$yr[nm[4]]-theirs$yr[tmp[nt]]
    nine[5,3,nt] <- mine$yr[nm[5]]-theirs$yr[tmp[nt]]
    nine[6,3,nt] <- mine$yr[nm[6]]-theirs$yr[tmp[nt]]
    nine[7,3,nt] <- mine$yr[nm[7]]-theirs$yr[tmp[nt]]
    nine[8,3,nt] <- mine$yr[nm[8]]-theirs$yr[tmp[nt]]
    nine[9,3,nt] <- mine$yr[nm[9]]-theirs$yr[tmp[nt]]
    nine[1,4,nt] <- mine$mo[nm[1]]-theirs$mo[tmp[nt]]
    nine[2,4,nt] <- mine$mo[nm[2]]-theirs$mo[tmp[nt]]
    nine[3,4,nt] <- mine$mo[nm[3]]-theirs$mo[tmp[nt]]
    nine[4,4,nt] <- mine$mo[nm[4]]-theirs$mo[tmp[nt]]
    nine[5,4,nt] <- mine$mo[nm[5]]-theirs$mo[tmp[nt]]
    nine[6,4,nt] <- mine$mo[nm[6]]-theirs$mo[tmp[nt]]
    nine[7,4,nt] <- mine$mo[nm[7]]-theirs$mo[tmp[nt]]
    nine[8,4,nt] <- mine$mo[nm[8]]-theirs$mo[tmp[nt]]
    nine[9,4,nt] <- mine$mo[nm[9]]-theirs$mo[tmp[nt]]
    nine[1,5,nt] <- mine$favor[nm[1]]-theirs$yea[tmp[nt]]
    nine[2,5,nt] <- mine$favor[nm[2]]-theirs$yea[tmp[nt]]
    nine[3,5,nt] <- mine$favor[nm[3]]-theirs$yea[tmp[nt]]
    nine[4,5,nt] <- mine$favor[nm[4]]-theirs$yea[tmp[nt]]
    nine[5,5,nt] <- mine$favor[nm[5]]-theirs$yea[tmp[nt]]
    nine[6,5,nt] <- mine$favor[nm[6]]-theirs$yea[tmp[nt]]
    nine[7,5,nt] <- mine$favor[nm[7]]-theirs$yea[tmp[nt]]
    nine[8,5,nt] <- mine$favor[nm[8]]-theirs$yea[tmp[nt]]
    nine[9,5,nt] <- mine$favor[nm[9]]-theirs$yea[tmp[nt]]
    nine[1,6,nt] <- mine$contra[nm[1]]-theirs$nay[tmp[nt]]
    nine[2,6,nt] <- mine$contra[nm[2]]-theirs$nay[tmp[nt]]
    nine[3,6,nt] <- mine$contra[nm[3]]-theirs$nay[tmp[nt]]
    nine[4,6,nt] <- mine$contra[nm[4]]-theirs$nay[tmp[nt]]
    nine[5,6,nt] <- mine$contra[nm[5]]-theirs$nay[tmp[nt]]
    nine[6,6,nt] <- mine$contra[nm[6]]-theirs$nay[tmp[nt]]
    nine[7,6,nt] <- mine$contra[nm[7]]-theirs$nay[tmp[nt]]
    nine[8,6,nt] <- mine$contra[nm[8]]-theirs$nay[tmp[nt]]
    nine[9,6,nt] <- mine$contra[nm[9]]-theirs$nay[tmp[nt]]
    nine[1,7,nt] <- mine$absten[nm[1]]-theirs$abs[tmp[nt]]
    nine[2,7,nt] <- mine$absten[nm[2]]-theirs$abs[tmp[nt]]
    nine[3,7,nt] <- mine$absten[nm[3]]-theirs$abs[tmp[nt]]
    nine[4,7,nt] <- mine$absten[nm[4]]-theirs$abs[tmp[nt]]
    nine[5,7,nt] <- mine$absten[nm[5]]-theirs$abs[tmp[nt]]
    nine[6,7,nt] <- mine$absten[nm[6]]-theirs$abs[tmp[nt]]
    nine[7,7,nt] <- mine$absten[nm[7]]-theirs$abs[tmp[nt]]
    nine[8,7,nt] <- mine$absten[nm[8]]-theirs$abs[tmp[nt]]
    nine[9,7,nt] <- mine$absten[nm[9]]-theirs$abs[tmp[nt]]
    }


# ASSIGN MATCHES (manually check only one exact match (5 zeroes) per set with "same" title; exceptions by hand at end)
obj <- nine
for (n in 1:dim(obj)[3]){
    for (r in 1:dim(obj)[1]){
        obj[r,8,n] <- ifelse (obj[r,3,n]==0 & obj[r,4,n]==0 & obj[r,5,n]==0 & obj[r,6,n]==0 & obj[r,7,n]==0, 1, 0)
        }
    }
nine <- obj
obj <- eight
for (n in 1:dim(obj)[3]){
    for (r in 1:dim(obj)[1]){
        obj[r,8,n] <- ifelse (obj[r,3,n]==0 & obj[r,4,n]==0 & obj[r,5,n]==0 & obj[r,6,n]==0 & obj[r,7,n]==0, 1, 0)
        }
    }
eight <- obj
obj <- seven
for (n in 1:dim(obj)[3]){
    for (r in 1:dim(obj)[1]){
        obj[r,8,n] <- ifelse (obj[r,3,n]==0 & obj[r,4,n]==0 & obj[r,5,n]==0 & obj[r,6,n]==0 & obj[r,7,n]==0, 1, 0)
        }
    }
seven <- obj
obj <- six
for (n in 1:dim(obj)[3]){
    for (r in 1:dim(obj)[1]){
        obj[r,8,n] <- ifelse (obj[r,3,n]==0 & obj[r,4,n]==0 & obj[r,5,n]==0 & obj[r,6,n]==0 & obj[r,7,n]==0, 1, 0)
        }
    }
six <- obj
obj <- five
for (n in 1:dim(obj)[3]){
    for (r in 1:dim(obj)[1]){
        obj[r,8,n] <- ifelse (obj[r,3,n]==0 & obj[r,4,n]==0 & obj[r,5,n]==0 & obj[r,6,n]==0 & obj[r,7,n]==0, 1, 0)
        }
    }
five <- obj
obj <- four
for (n in 1:dim(obj)[3]){
    for (r in 1:dim(obj)[1]){
        obj[r,8,n] <- ifelse (obj[r,3,n]==0 & obj[r,4,n]==0 & obj[r,5,n]==0 & obj[r,6,n]==0 & obj[r,7,n]==0, 1, 0)
        }
    }
four <- obj
obj <- three
for (n in 1:dim(obj)[3]){
    for (r in 1:dim(obj)[1]){
        obj[r,8,n] <- ifelse (obj[r,3,n]==0 & obj[r,4,n]==0 & obj[r,5,n]==0 & obj[r,6,n]==0 & obj[r,7,n]==0, 1, 0)
        }
    }
three <- obj
obj <- two
for (n in 1:dim(obj)[3]){
    for (r in 1:dim(obj)[1]){
        obj[r,8,n] <- ifelse (obj[r,3,n]==0 & obj[r,4,n]==0 & obj[r,5,n]==0 & obj[r,6,n]==0 & obj[r,7,n]==0, 1, 0)
        }
    }
two <- obj
# THESE BY HAND (should be more robust if third index were chosen by VID)
seven[1,8,1] <- 1 # VID 469 = folio 475 it seems
four[3,8,18] <- 1 # VID 829 = folio 903 it seems
three[1,8,4] <- 1 # date mismatch only
three[2,8,5] <- 1 # date mismatch only
three[3,8,6] <- 1 # date mismatch only
## Some of their votes have NA nays etc... these have no match in mine
#
obj <- nine
for (n in 1:dim(obj)[3]){
    for (r in 1:dim(obj)[1]){
        match[obj[r,1,n],1] <- ifelse (obj[r,8,n]==1, obj[r,1,n], match[obj[r,1,n],1]  )
        match[obj[r,1,n],2] <- ifelse (obj[r,8,n]==1, obj[r,2,n], match[obj[r,1,n],2]  )
        }
    }
obj <- eight
for (n in 1:dim(obj)[3]){
    for (r in 1:dim(obj)[1]){
        match[obj[r,1,n],1] <- ifelse (obj[r,8,n]==1, obj[r,1,n], match[obj[r,1,n],1]  )
        match[obj[r,1,n],2] <- ifelse (obj[r,8,n]==1, obj[r,2,n], match[obj[r,1,n],2]  )
        }
    }
obj <- seven
for (n in 1:dim(obj)[3]){
    for (r in 1:dim(obj)[1]){
        match[obj[r,1,n],1] <- ifelse (obj[r,8,n]==1, obj[r,1,n], match[obj[r,1,n],1]  )
        match[obj[r,1,n],2] <- ifelse (obj[r,8,n]==1, obj[r,2,n], match[obj[r,1,n],2]  )
        }
    }
obj <- six
for (n in 1:dim(obj)[3]){
    for (r in 1:dim(obj)[1]){
        match[obj[r,1,n],1] <- ifelse (obj[r,8,n]==1, obj[r,1,n], match[obj[r,1,n],1]  )
        match[obj[r,1,n],2] <- ifelse (obj[r,8,n]==1, obj[r,2,n], match[obj[r,1,n],2]  )
        }
    }
obj <- five
for (n in 1:dim(obj)[3]){
    for (r in 1:dim(obj)[1]){
        match[obj[r,1,n],1] <- ifelse (obj[r,8,n]==1, obj[r,1,n], match[obj[r,1,n],1]  )
        match[obj[r,1,n],2] <- ifelse (obj[r,8,n]==1, obj[r,2,n], match[obj[r,1,n],2]  )
        }
    }
obj <- four
for (n in 1:dim(obj)[3]){
    for (r in 1:dim(obj)[1]){
        match[obj[r,1,n],1] <- ifelse (obj[r,8,n]==1, obj[r,1,n], match[obj[r,1,n],1]  )
        match[obj[r,1,n],2] <- ifelse (obj[r,8,n]==1, obj[r,2,n], match[obj[r,1,n],2]  )
        }
    }
obj <- three
for (n in 1:dim(obj)[3]){
    for (r in 1:dim(obj)[1]){
        match[obj[r,1,n],1] <- ifelse (obj[r,8,n]==1, obj[r,1,n], match[obj[r,1,n],1]  )
        match[obj[r,1,n],2] <- ifelse (obj[r,8,n]==1, obj[r,2,n], match[obj[r,1,n],2]  )
        }
    }
obj <- two
for (n in 1:dim(obj)[3]){
    for (r in 1:dim(obj)[1]){
        match[obj[r,1,n],1] <- ifelse (obj[r,8,n]==1, obj[r,1,n], match[obj[r,1,n],1]  )
        match[obj[r,1,n],2] <- ifelse (obj[r,8,n]==1, obj[r,2,n], match[obj[r,1,n],2]  )
        }
    }
#
# REPLACE NAs
match$VID <- 1:length(match$VID)
# Input VID values into mine$VID
match2 <- match[order(match$folio),]
match2 <- match2[match2$folio>0 & is.na(match2$folio)==FALSE,] ## keeps matches only
#
for (n in 1:length(match2$folio)){
    mine$VID[match2$folio[n]] <- match2$VID[n]
    }
#
## CHECK HOW DIFFERENT ARE TITLES MATCHING ONCE ONLY IN OTHER ASPECTS
tmp <- rep(NA, times=length(theirs$yr))
diff <- data.frame(folio= tmp, yr=tmp, mo=tmp, dy=tmp, fav=tmp, con=tmp, abs=tmp, quo=tmp, aus=tmp)
for (n in 1:length(theirs$yr)){
    diff$folio[n] <- ifelse ( nMatches[n]==0, NA,  match[n,2])
    diff$yr[n] <- ifelse ( nMatches[n]==0, NA,  mine$yr[match[n,2]]-theirs$yr[n]     )
    diff$mo[n] <- ifelse ( nMatches[n]==0, NA,  mine$mo[match[n,2]]-theirs$mo[n]     )
    diff$dy[n] <- ifelse ( nMatches[n]==0, NA,  mine$dy[match[n,2]]-theirs$dy[n]     )
    diff$fav[n] <- ifelse ( nMatches[n]==0, NA, mine$favor[match[n,2]]-theirs$yea[n] )
    diff$con[n] <- ifelse ( nMatches[n]==0, NA, mine$contra[match[n,2]]-theirs$nay[n])
    diff$abs[n] <- ifelse ( nMatches[n]==0, NA, mine$absten[match[n,2]]-theirs$abs[n])
    diff$quo[n] <- ifelse ( nMatches[n]==0, NA, mine$quorum[match[n,2]]-theirs$quo[n])
    diff$aus[n] <- ifelse ( nMatches[n]==0, NA, mine$ausen[match[n,2]]-theirs$unat[n])
    }
#

## JOINS THEIR DATA AND MINE
#
## DROPS THEIRS OBSERVATIONS 1660:1691 THAT HAVE NO ROLL CALL INFO (AND ALL MATCH CASES I HAVE)
theirs <- theirs[1:1659,]; match <- match[1:1659,]
#
## THESE VOTES IN THEIRS HAVE NO MATCH IN MINE
match$VID[match$folio==0] ## SHOULD BE EMPTY
## THESE VOTES IN MINE HAVE NO MATCH IN THEIRS
mine$folio[mine$VID==0]
#

## Number of obs in caps (useful if they were to get some votes absent in mine only)
M <- dim(mine)[1] # mine
T <- dim(theirs)[1] # theirs
TO <- length(match$VID[match$folio==0])  # theirs only
MO <- length(mine$folio[mine$VID==0]) # mine only
ALL <- M+TO # mine + theirs only = all
#
jo <- data.frame(folio=mine$folio, VID=mine$VID, yr=mine$yr, mo=mine$mo, dy=mine$dy, leg=mine$leg, filename=mine$filename, favor=mine$favor, contra=mine$contra, absten=mine$absten, quorum=mine$quorum, ausen=mine$ausen, title=mine$title)
#
#tmp <- rep(NA, times=ALL)
#jo <- data.frame(folio=c(1:ALL), yr=tmp, mo=tmp, dy=tmp, leg=tmp, filename=tmp, favor=tmp, contra=tmp, absten=tmp,
#quorum=tmp, ausen=tmp, title=tmp, VID=tmp, vote_date=tmp, leg_num=tmp, period=tmp, period_vote=tmp, yea=tmp, nay=tmp,
#abs=tmp, quo=tmp, unat=tmp, vote_desc=tmp)
##
### ENTERS VIDs FOR MATCHING FOLIOS AND THEIRS ONLY
#for (n in 1:M){
#    jo$VID[n] <- ifelse (mine$folio[n]==jo$folio[n], mine$VID[n], 0)
#    }
#jo$VID[(M+1):ALL] <- match$VID[match$folio==0]
##
### FILLS IN DATA
#for (n in 1:M){
#    jo$yr[n] <- ifelse (mine$folio[n]==jo$folio[n], mine$yr[n], 0)
#    jo$mo[n] <- ifelse (mine$folio[n]==jo$folio[n], mine$mo[n], 0)
#    jo$dy[n] <- ifelse (mine$folio[n]==jo$folio[n], mine$dy[n], 0)
#    jo$leg[n] <- ifelse (mine$folio[n]==jo$folio[n], mine$leg[n], 0)
#    jo$filename[n] <- ifelse (mine$folio[n]==jo$folio[n], mine$filename[n], 0)
#    jo$favor[n] <- ifelse (mine$folio[n]==jo$folio[n], mine$favor[n], 0)
#    jo$contra[n] <- ifelse (mine$folio[n]==jo$folio[n], mine$contra[n], 0)
#    jo$absten[n] <- ifelse (mine$folio[n]==jo$folio[n], mine$absten[n], 0)
#    jo$quorum[n] <- ifelse (mine$folio[n]==jo$folio[n], mine$quorum[n], 0)
#    jo$ausen[n] <- ifelse (mine$folio[n]==jo$folio[n], mine$ausen[n], 0)
#    jo$title[n] <- ifelse (mine$folio[n]==jo$folio[n], mine$title[n], 0)
#    }
#jo$vote_date[(M+1):ALL] <- as.character(theirs$vote_date[match$folio==0])
#jo$leg_num[(M+1):ALL] <- theirs$leg[match$folio==0]
#jo$period[(M+1):ALL] <- theirs$period[match$folio==0]
#jo$period_vote[(M+1):ALL] <- theirs$period_vote_id[match$folio==0]
#jo$yea[(M+1):ALL] <- theirs$yea[match$folio==0]
#jo$nay[(M+1):ALL] <- theirs$nay[match$folio==0]
#jo$abs[(M+1):ALL] <- theirs$abs[match$folio==0]
#jo$quo[(M+1):ALL] <- theirs$quo[match$folio==0]
#jo$unat[(M+1):ALL] <- theirs$unat[match$folio==0]
#jo$vote_desc[(M+1):ALL] <- theirs$title[match$folio==0]
joint <- jo; rm(jo)

write.table(joint, file="mine-theirs.xls", sep=",")



###########################################################################
###########################################################################
###########################################################################
####             SEARCH ROLL CALLS IN WEB              ####################
###########################################################################
###########################################################################
###########################################################################

## THIS PORTION WORKS WITH GACETA INFO (MANY VOTES MISSING ARE RECOVERED BELOW)
rm(list = ls())
## PATH TO WORKING DIRECTORY IN DISK
DipMex <- c("d:/01/dropbox/data/rollcall/DipMex")
#DipMex <- c("C:/Documents and Settings/emm/Mis documentos/My Dropbox/data/rollcall/DipMex")
#DipMex <- c("C:/Documents and Settings/emagarm/Mis documentos/My Dropbox/data/rollcall/DipMex")
setwd(DipMex)
load(paste(DipMex, "/voTabs.RData", sep=""))
#
dat$yr <- as.numeric(dat$yr); dat$mo <- as.numeric(dat$mo); dat$dy <- as.numeric(dat$dy);
#dat$maxTab <- NA ## info se borraba cada vez que tronaba el web
#
tmp     <- sub(dat$filename, pattern="tabla", replacement="")
tmpvnum <- as.numeric( sub(tmp, pattern=".*-", replacement="") )
tmpyr   <- as.numeric( sub(tmp, pattern="([0-9]).*", replacement="\\1") )
tmpper <- sub(tmp, pattern="[0-9]([oe].*)[0-9]{1-3}-.*", , replacement="\\1")
tmpper <- sub(tmpper, pattern="ex.*", replacement="extra"); tmpper <- sub(tmpper, pattern="or", replacement="ordi")
tmppershort <- tmpper; tmppershort[tmpper=="ordi"] <- "or"; tmppershort[tmpper=="extra"] <- "ex"
tmppern <- as.numeric( sub(tmp, pattern="[0-9][oe].*([0-9]{1-3})-.*", , replacement="\\1") )
webayes <- paste("http://gaceta.diputados.gob.mx/voto", dat$leg, "/", tmpper, tmpyr, tmppern, "/",
                 "lan", tmpper, tmpyr, tmppern, ".php3", "?evento=", tmpvnum,
                 "&nomtit=Reconstruido+por+EMM&lola%5B11%5D=", dat$favor, sep="")
webnays <- paste("http://gaceta.diputados.gob.mx/voto", dat$leg, "/", tmpper, tmpyr, tmppern, "/",
                 "lan", tmpper, tmpyr, tmppern, ".php3", "?evento=", tmpvnum,
                 "&nomtit=Reconstruido+por+EMM&lola%5B12%5D=", dat$contra, sep="")
webabsten <- paste("http://gaceta.diputados.gob.mx/voto", dat$leg, "/", tmpper, tmpyr, tmppern, "/",
                 "lan", tmpper, tmpyr, tmppern, ".php3", "?evento=", tmpvnum,
                 "&nomtit=Reconstruido+por+EMM&lola%5B13%5D=", dat$absten, sep="")
webquorum <- paste("http://gaceta.diputados.gob.mx/voto", dat$leg, "/", tmpper, tmpyr, tmppern, "/",
                 "lan", tmpper, tmpyr, tmppern, ".php3", "?evento=", tmpvnum,
                 "&nomtit=Reconstruido+por+EMM&lola%5B14%5D=", dat$quorum, sep="")
webausen <- paste("http://gaceta.diputados.gob.mx/voto", dat$leg, "/", tmpper, tmpyr, tmppern, "/",
                 "lan", tmpper, tmpyr, tmppern, ".php3", "?evento=", tmpvnum,
                 "&nomtit=Reconstruido+por+EMM&lola%5B15%5D=", dat$ausen, sep="")

filenames<-paste(DipMex, "/matweb/votes/",
dat$leg, "yr", tmpyr, tmppershort, tmppern, "-", tmpvnum, ".txt",sep="")
dontdo <- file.exists( filenames )
tmp <- 1:length(dontdo)
work <- tmp[dontdo=="FALSE"]
#
## VOTE DOWNLOAD
votmiss <- c(40, 56, 550, 757:814, 1708) ## indices of votes missing (1708 falta parcialmente, se puede reconstruir desde web)
allts <- c(21:25,31:35,41:45,51:55,61:65,71:75,81:85,91:95,101:105,111:115,121:125,131:135,141:145,151:155)
#
#n <- 2066
for (n in work){
    tmp <- c(paste("fch =", dat$yr[n]*10000+dat$mo[n]*100+dat$dy[n]), paste("leg =",dat$leg[n]),
                   sub(dat$filename[n], pattern="tabla", replacement=""), dat$title[n])
    ## DETERMINA N�MERO DE CELDAS EN TABLA
    direc <- paste("http://gaceta.diputados.gob.mx/voto", dat$leg[n], "/", tmpper[n], tmpyr[n], tmppern[n], "/", tmpvnum[n], "/", sep="")
    url <- url(direc,open="rt")
    tmp2 <- readLines(url, warn=FALSE)
    close(url)
    tmp3 <- grep(tmp2, pattern="<h1>Index.*"); tmp2 <- tmp2[tmp3:length(tmp2)] ## QUITA PREAMBULO
    tmp2 <- sub(tmp2, pattern=".*<a href=", replacement="")
    tmp3 <- sub(tmp2, pattern="\\Q\"\\E([1-9][0-9][1-5]{0-1}).*", replacement="\\1")
    tmp3 <- as.numeric( tmp3[grep(tmp3, pattern="^[0-9]")] ) ## Deja s�lo renglones que empiezan en n�mero
    mxt <- max(tmp3, na.rm="TRUE"); usedts <- allts[allts<=mxt]; #dat$maxTab[n] <- mxt
    usay <- usedts[usedts-as.integer(usedts/10)*10==1]  ## AYE TABLES TO SCAN
    usny <- usedts[usedts-as.integer(usedts/10)*10==2]
    usab <- usedts[usedts-as.integer(usedts/10)*10==3]
    usqu <- usedts[usedts-as.integer(usedts/10)*10==4]
    usas <- usedts[usedts-as.integer(usedts/10)*10==5]
    ##
    tmp <- append(tmp, c("emmAyesStart"))
    M <- length(usay)
    for (m in 1:M){
        direc <- paste("http://gaceta.diputados.gob.mx/voto", dat$leg[n], "/",
                 tmpper[n], tmpyr[n], tmppern[n], "/", tmpvnum[n], "/", usay[m], sep="")
        url <- url(direc,open="rt")
        tmp2 <- readLines(url, warn=FALSE)
        close(url)
        tmp <- append(tmp, tmp2)
        }
    tmp <- append(tmp, c("emmNaysStart"))
    for (m in 1:M){
        direc <- paste("http://gaceta.diputados.gob.mx/voto", dat$leg[n], "/",
                 tmpper[n], tmpyr[n], tmppern[n], "/", tmpvnum[n], "/", usny[m], sep="")
        url <- url(direc,open="rt")
        tmp2 <- readLines(url, warn=FALSE)
        close(url)
        tmp <- append(tmp, tmp2)
        }
    tmp <- append(tmp, c("emmAbstentionsStart"))
    for (m in 1:M){
        direc <- paste("http://gaceta.diputados.gob.mx/voto", dat$leg[n], "/",
                 tmpper[n], tmpyr[n], tmppern[n], "/", tmpvnum[n], "/", usab[m], sep="")
        url <- url(direc,open="rt")
        tmp2 <- readLines(url, warn=FALSE)
        close(url)
        tmp <- append(tmp, tmp2)
        }
    tmp <- append(tmp, c("emmPresentNoVoteStart"))
    for (m in 1:M){
        direc <- paste("http://gaceta.diputados.gob.mx/voto", dat$leg[n], "/",
                 tmpper[n], tmpyr[n], tmppern[n], "/", tmpvnum[n], "/", usqu[m], sep="")
        url <- url(direc,open="rt")
        tmp2 <- readLines(url, warn=FALSE)
        close(url)
        tmp <- append(tmp, tmp2)
        }
    tmp <- append(tmp, c("emmAbsencesStart"))
    for (m in 1:M){
        direc <- paste("http://gaceta.diputados.gob.mx/voto", dat$leg[n], "/",
                 tmpper[n], tmpyr[n], tmppern[n], "/", tmpvnum[n], "/", usas[m], sep="")
        url <- url(direc,open="rt")
        tmp2 <- readLines(url, warn=FALSE)
        close(url)
        tmp <- append(tmp, tmp2)
        }
    tmp <- append(tmp, "emmFileEnds")
    filename<-paste(DipMex, "/matweb/votes/",
                      dat$leg[n], "yr", tmpyr[n], tmppershort[n], tmppern[n], "-", tmpvnum[n], ".txt",sep="")
    write(tmp, filename)
    #paste("iteration =", n, "leg =", dat$leg[n], dat$filename[n])
    }
## END OF GACETA ROLL CALL DOWNLOAD

########################################
## VOTES NOT IN GACETA BUT IN INFOSIL ##
########################################

workdir <- c("d:/01/dropbox/data/rollcall/DipMex/matweb/votes/")
#workdir <- c("C:/Documents and Settings/emm/Mis documentos/My Dropbox/data/rollcall/DipMex/matweb/votes/")
#workdir <- c("C:/Documents and Settings/emagarm/Mis documentos/My Dropbox/data/rollcall/DipMex/matweb/votes/")
setwd(workdir)

###############
##  60 LEG   ##
###############

## VOTACIONT= CORRESPONDING TO VOTES IN SIL (INCLUDES ALL IN GACETA AS WELL AS MISSING)
vot60 <- c(1:263,265:297,310:577,579:604) ## THERE ARE SEQUENCE BREAKS ... SHOULD BE 1:590
#
pp <- c(3,  ## pan
        1,  ## pri
        2,  ## prd
        4,  ## pt
        5,  ## pvem
        6,  ## conve
        12, ## panal
        13, ## asd
        9)  ## indep
#
path <- "http://sitl.diputados.gob.mx/listados_votacionesnp.php?partidot="
webpan   <- paste(path, pp[1], "&votaciont=", vot60, sep="")
webpri   <- paste(path, pp[2], "&votaciont=", vot60, sep="")
webprd   <- paste(path, pp[3], "&votaciont=", vot60, sep="")
webpt    <- paste(path, pp[4], "&votaciont=", vot60, sep="")
webpvem  <- paste(path, pp[5], "&votaciont=", vot60, sep="")
webconve <- paste(path, pp[6], "&votaciont=", vot60, sep="")
webpanal <- paste(path, pp[7], "&votaciont=", vot60, sep="")
webasd   <- paste(path, pp[8], "&votaciont=", vot60, sep="")
webindep <- paste(path, pp[9], "&votaciont=", vot60, sep="")
#
tmp <- c( rep("yr1or1", times=47), rep("yr1or2", times=79),
          rep("yr2or1", times=122), rep("yr2or2", times=74),
          rep("yr2ex2", times=15),
          rep("yr3or1", times=102), rep("yr3or2", times=151) )
filenames <- paste( workdir, 60, tmp, "-sil-", vot60, ".txt", sep="")

dontdo <- file.exists( filenames )
tmp <- 1:length(dontdo)
work <- tmp[dontdo=="FALSE"]
#n <- 298
for (n in work){
    #
    ## pan
    url <- url( webpan[n], open="rt" )
    tmp<- readLines(url, warn=FALSE)
    close(url)
    tmp2 <- grep(tmp, pattern="<tr bgcolor=\\Q\"\\E#E3DAC1")
    tmp <- tmp[(tmp2+1):length(tmp)] ## REMOVES PREAMBLE
    fch <- sub(tmp[1], pattern=".*DE LA SESI�N DEL (.*)</u> <BR> (.*)</B>.*", replacement="\\1")
    tit <- sub(tmp[1], pattern=".*DE LA SESI�N DEL (.*)</u> <BR> (.*)</B>.*", replacement="\\2")
    tmp2 <- grep(tmp, pattern="Sentido del voto")
    tmp <- tmp[(tmp2+1):length(tmp)] ## REMOVES JUNK TIL START OF NAMES LIST
    vote <- c( paste("fch =", fch), "leg = 61", sub (filenames[n], pattern=".*(yr.*).txt", replacement="\\1"), tit, "emmPanVoteStart")
    vote <- append ( vote, tmp )
    #
    ## pri
    url <- url( webpri[n], open="rt" )
    tmp<- readLines(url, warn=FALSE)
    close(url)
    tmp2 <- grep(tmp, pattern="Sentido del voto")
    tmp <- c( "emmPriVoteStart", tmp[(tmp2+1):length(tmp)] ) ## REMOVES JUNK TIL START OF NAMES LIST
    vote <- append ( vote, tmp )
    #
    ## prd
    url <- url( webprd[n], open="rt" )
    tmp<- readLines(url, warn=FALSE)
    close(url)
    tmp2 <- grep(tmp, pattern="Sentido del voto")
    tmp <- c( "emmPrdVoteStart", tmp[(tmp2+1):length(tmp)] ) ## REMOVES JUNK TIL START OF NAMES LIST
    vote <- append ( vote, tmp )
    #
    ## pt
    url <- url( webpt[n], open="rt" )
    tmp<- readLines(url, warn=FALSE)
    close(url)
    tmp2 <- grep(tmp, pattern="Sentido del voto")
    tmp <- c( "emmPtVoteStart", tmp[(tmp2+1):length(tmp)] ) ## REMOVES JUNK TIL START OF NAMES LIST
    vote <- append ( vote, tmp )
    #
    ## pvem
    url <- url( webpvem[n], open="rt" )
    tmp<- readLines(url, warn=FALSE)
    close(url)
    tmp2 <- grep(tmp, pattern="Sentido del voto")
    tmp <- c( "emmPvemVoteStart", tmp[(tmp2+1):length(tmp)] ) ## REMOVES JUNK TIL START OF NAMES LIST
    vote <- append ( vote, tmp )
    #
    ## conve
    url <- url( webconve[n], open="rt" )
    tmp<- readLines(url, warn=FALSE)
    close(url)
    tmp2 <- grep(tmp, pattern="Sentido del voto")
    tmp <- c( "emmConveVoteStart", tmp[(tmp2+1):length(tmp)] ) ## REMOVES JUNK TIL START OF NAMES LIST
    vote <- append ( vote, tmp )
    #
    ## panal
    url <- url( webpanal[n], open="rt" )
    tmp<- readLines(url, warn=FALSE)
    close(url)
    tmp2 <- grep(tmp, pattern="Sentido del voto")
    tmp <- c( "emmPanalVoteStart", tmp[(tmp2+1):length(tmp)] ) ## REMOVES JUNK TIL START OF NAMES LIST
    vote <- append ( vote, tmp )
    #
    ## asd
    url <- url( webasd[n], open="rt" )
    tmp<- readLines(url, warn=FALSE)
    close(url)
    tmp2 <- grep(tmp, pattern="Sentido del voto")
    tmp <- c( "emmAsdVoteStart", tmp[(tmp2+1):length(tmp)] ) ## REMOVES JUNK TIL START OF NAMES LIST
    vote <- append ( vote, tmp )
    #
    ## indep
    url <- url( webindep[n], open="rt" )
    tmp<- readLines(url, warn=FALSE)
    close(url)
    tmp2 <- grep(tmp, pattern="Sentido del voto")
    tmp <- c( "emmIndepVoteStart", tmp[(tmp2+1):length(tmp)] ) ## REMOVES JUNK TIL START OF NAMES LIST
    vote <- append ( vote, tmp )
    ##
    write(vote, filenames[n])
    #paste("iteration =", n, "leg =", dat$leg[n], dat$filename[n])
    }

##
## SAVE INFOSIL FILENAMES INFO FOR USE IN RC SYSTEMATIZATION
save(filenames, file=paste("d:/01/dropbox/data/rollcall/DipMex","/infosilFilenames60.RData",sep=""))

###############
##  61 LEG   ##
###############

rm(list = ls())
DipMex <-  c("d:/01/dropbox/data/rollcall/DipMex")
workdir <- c("d:/01/dropbox/data/rollcall/DipMex/matweb/votes/")
#workdir <- c("C:/Documents and Settings/emm/Mis documentos/My Dropbox/data/rollcall/DipMex/matweb/votes/")
#workdir <- c("C:/Documents and Settings/emagarm/Mis documentos/My Dropbox/data/rollcall/DipMex/matweb/votes/")
setwd(workdir)

## VOTACIONT= CORRESPONDING TO VOTES IN INFOPAL (INCLUDES ALL IN GACETA AS WELL AS MISSING)
##vot61 <- c(1, 2, 25, 26, 28, 29, 33, 35, 36,        ## THESE ARE VOTES MISSING FROM GACETA
##           55, 57, 95, 100, 124, 125,               ## UP TO MAY 2011
##           149, 168, 185, 202, 203, 215, 235,       ##
##           242, 264, 270, 275, 281, 304, 321, 373)  ##
###
vot61 <- 1:373  ## IGNORING VOTES IN GACETA BECAUSE MERGE IS COMPLICATED... UP TO MAY 2011
#
# THIS ADDS VOTES BETWEEN MAY AND DEC 2011 (ALL TAKEN FROM INFOPAL, NOT GACETA)
vot61 <- c(vot61, 374:389, 391:439, 441:555, 557:613, 614:704)   ## LIKE 60th, INFOPAL SKIPS SOME NUMBERS
newvots <- 705:741                                               ## USE THIS TO ISOLATE NEW VOTES
vot61 <- c(vot61, newvots)
                                        #
# TO ADD 2012 VOTES, REPEAT/ADAPT METHOD IN LINES ABOVE (AND newfilenames BELOW)
#
pp <- c(3,  ## pan
        1,  ## pri
        2,  ## prd
        4,  ## pt
        5,  ## pvem
        6,  ## conve
        12, ## panal
        9)  ## indep
#
path <- "http://sitl.diputados.gob.mx/LXI_leg/listados_votacionesnplxi.php?partidot="
webpan   <- paste(path, pp[1], "&votaciont=", vot61, sep="")
webpri   <- paste(path, pp[2], "&votaciont=", vot61, sep="")
webprd   <- paste(path, pp[3], "&votaciont=", vot61, sep="")
webpt    <- paste(path, pp[4], "&votaciont=", vot61, sep="")
webpvem  <- paste(path, pp[5], "&votaciont=", vot61, sep="")
webconve <- paste(path, pp[6], "&votaciont=", vot61, sep="")
webpanal <- paste(path, pp[7], "&votaciont=", vot61, sep="")
webindep <- paste(path, pp[8], "&votaciont=", vot61, sep="")
#
ses <- c( rep("yr1or1", times=41),
          rep("yr1or2", times=83),
          rep("yr2or1", times=115),
          rep("yr2or2", times=134),
          rep("yr3or1", times=237),
          rep("yr3or2", times=128) )
filenames <- paste( workdir, 61, ses, "-sil-", vot61, ".txt", sep="")
newfilenames <- paste( workdir, 61, "yr3or2", "-sil-", newvots, ".txt", sep="")
dontdo <- file.exists( filenames )
tmp <- 1:length(dontdo)
work <- tmp[dontdo=="FALSE"]

#n <- 1
for (n in work){
    #
    ## pan
    url <- url( webpan[n], open="rt" )
    tmp<- readLines(url, warn=FALSE)
    close(url)
    tmp2 <- grep(tmp, pattern="<tr bgcolor=\\Q\"\\E#E3DAC1")
    tmp <- tmp[(tmp2+1):length(tmp)] ## REMOVES PREAMBLE
    fch <- sub(tmp[1], pattern=".*DE LA SESI�N DEL (.*)</u> <BR> (.*)</B>.*", replacement="\\1")
    tit <- sub(tmp[1], pattern=".*DE LA SESI�N DEL (.*)</u> <BR> (.*)</B>.*", replacement="\\2")
    tmp2 <- grep(tmp, pattern="Sentido del voto")
    tmp <- tmp[(tmp2+1):length(tmp)] ## REMOVES JUNK TIL START OF NAMES LIST
    vote <- c( paste("fch =", fch), "leg = 61", sub (filenames[n], pattern=".*(yr.*).txt", replacement="\\1"), tit, "emmPanVoteStart")
    vote <- append ( vote, tmp )
    #
    ## pri
    url <- url( webpri[n], open="rt" )
    tmp<- readLines(url, warn=FALSE)
    close(url)
    tmp2 <- grep(tmp, pattern="Sentido del voto")
    tmp <- c( "emmPriVoteStart", tmp[(tmp2+1):length(tmp)] ) ## REMOVES JUNK TIL START OF NAMES LIST
    vote <- append ( vote, tmp )
    #
    ## prd
    url <- url( webprd[n], open="rt" )
    tmp<- readLines(url, warn=FALSE)
    close(url)
    tmp2 <- grep(tmp, pattern="Sentido del voto")
    tmp <- c( "emmPrdVoteStart", tmp[(tmp2+1):length(tmp)] ) ## REMOVES JUNK TIL START OF NAMES LIST
    vote <- append ( vote, tmp )
    #
    ## pt
    url <- url( webpt[n], open="rt" )
    tmp<- readLines(url, warn=FALSE)
    close(url)
    tmp2 <- grep(tmp, pattern="Sentido del voto")
    tmp <- c( "emmPtVoteStart", tmp[(tmp2+1):length(tmp)] ) ## REMOVES JUNK TIL START OF NAMES LIST
    vote <- append ( vote, tmp )
    #
    ## pvem
    url <- url( webpvem[n], open="rt" )
    tmp<- readLines(url, warn=FALSE)
    close(url)
    tmp2 <- grep(tmp, pattern="Sentido del voto")
    tmp <- c( "emmPvemVoteStart", tmp[(tmp2+1):length(tmp)] ) ## REMOVES JUNK TIL START OF NAMES LIST
    vote <- append ( vote, tmp )
    #
    ## conve
    url <- url( webconve[n], open="rt" )
    tmp<- readLines(url, warn=FALSE)
    close(url)
    tmp2 <- grep(tmp, pattern="Sentido del voto")
    tmp <- c( "emmConveVoteStart", tmp[(tmp2+1):length(tmp)] ) ## REMOVES JUNK TIL START OF NAMES LIST
    vote <- append ( vote, tmp )
    #
    ## panal
    url <- url( webpanal[n], open="rt" )
    tmp<- readLines(url, warn=FALSE)
    close(url)
    tmp2 <- grep(tmp, pattern="Sentido del voto")
    tmp <- c( "emmPanalVoteStart", tmp[(tmp2+1):length(tmp)] ) ## REMOVES JUNK TIL START OF NAMES LIST
    vote <- append ( vote, tmp )
    #
    ## indep
    url <- url( webindep[n], open="rt" )
    tmp<- readLines(url, warn=FALSE)
    close(url)
    tmp2 <- grep(tmp, pattern="Sentido del voto")
    tmp <- c( "emmIndepVoteStart", tmp[(tmp2+1):length(tmp)] ) ## REMOVES JUNK TIL START OF NAMES LIST
    vote <- append ( vote, tmp )
    ##
    write(vote, filenames[n])
    #paste("iteration =", n, "leg =", dat$leg[n], dat$filename[n])
    }
##
## SAVE INFOSIL FILENAMES INFO FOR USE IN NEW RC SYSTEMATIZATION
filenames <- newfilenames
save(filenames, file=paste(DipMex,"/infosilFilenames.RData",sep=""))
## END OF INFOSIL ROLL CALL DOWNLOAD



###############
##  62 LEG   ##
###############

rm(list = ls())
#DipMex <-  c("~/Dropbox/data/rollcall/dipMex")
#workdir <- c("~/Dropbox/data/rollcall/dipMex/matweb/votes/")
#DipMex <-  c("d:/01/dropbox/data/rollcall/dipMex")
#workdir <- c("d:/01/dropbox/data/rollcall/dipMex/matweb/votes/")
#workdir <- c("C:/Documents and Settings/emm/Mis documentos/My Dropbox/data/rollcall/dipMex/matweb/votes/")
DipMex <-  c("C:/Users/emagarm/Documents/Dropbox/data/rollcall/dipMex")
workdir <-  c("C:/Users/emagarm/Documents/Dropbox/data/rollcall/dipMex/matweb/votes/")
setwd(workdir)

vot62 <- c(1, 2, 4:9, 11:17, 19:21, 25:28, 31, 33:35, 37, 39:41, 43:46, 49:54, 56:59, 61:69, 71:74, 77, 82:86) ## 1er periodo
newvots <- vot62
#vot62 <- c(vot62, newvots) # needed when adding more votes
#
# TO ADD 2012 VOTES, REPEAT/ADAPT METHOD IN LINES ABOVE (AND newfilenames BELOW)
#
pp <- c(3,  ## pan
        1,  ## pri
        2,  ## prd
        4,  ## pt
        5,  ## pvem
        6,  ## mc (ex conve)
        12, ## panal
        9)  ## indep
#

path <- "http://sitl.diputados.gob.mx/LXII_leg/listados_votacionesnplxii.php?partidot="
webpan   <- paste(path, pp[1], "&votaciont=", vot62, sep="")
webpri   <- paste(path, pp[2], "&votaciont=", vot62, sep="")
webprd   <- paste(path, pp[3], "&votaciont=", vot62, sep="")
webpt    <- paste(path, pp[4], "&votaciont=", vot62, sep="")
webpvem  <- paste(path, pp[5], "&votaciont=", vot62, sep="")
webconve <- paste(path, pp[6], "&votaciont=", vot62, sep="")
webpanal <- paste(path, pp[7], "&votaciont=", vot62, sep="")
webindep <- paste(path, pp[8], "&votaciont=", vot62, sep="")
#
ses <- c( rep("yr1or1", times=63) ) #,
#          rep("yr1or2", times=83),
#          rep("yr2or1", times=115),
#          rep("yr2or2", times=134),
#          rep("yr3or1", times=237),
#          rep("yr3or2", times=128) )
filenames <- paste( workdir, 62, ses, "-sil-", vot62, ".txt", sep="")
newfilenames <- paste( workdir, 62, "yr3or2", "-sil-", newvots, ".txt", sep="")
dontdo <- file.exists( filenames )
tmp <- 1:length(dontdo)
work <- tmp[dontdo=="FALSE"]

n <- 2
for (n in work){
    #
    ## pan
    url <- url( webpan[n], open="rt", encoding = "ISO-8859-1")
    tmp<- readLines(url, warn=FALSE)
    close(url)
    tmp2 <- grep(tmp, pattern="<tr bgcolor=\\Q\"\\E#E3DAC1")
    tmp <- tmp[(tmp2+1):length(tmp)] ## REMOVES PREAMBLE
#    fch <- sub(tmp[1], pattern=".*DE LA SESI�N DEL (.*)</u> <BR> (.*)</B>.*", replacement="\\1")
    fch <- sub(tmp[1], pattern=".*DE LA SESI\xd3N DEL (.*)</u> <BR> (.*)</B>.*", replacement="\\1")
#    tit <- sub(tmp[1], pattern=".*DE LA SESI�N DEL (.*)</u> <BR> (.*)</B>.*", replacement="\\2")
    tit <- sub(tmp[1], pattern=".*DE LA SESI\xd3N DEL (.*)</u> <BR> (.*)</B>.*", replacement="\\2")
    tmp2 <- grep(tmp, pattern="Sentido del voto")
    tmp <- tmp[(tmp2+1):length(tmp)] ## REMOVES JUNK TIL START OF NAMES LIST
    vote <- c( paste("fch =", fch), "leg = 61", sub (filenames[n], pattern=".*(yr.*).txt", replacement="\\1"), tit, "emmPanVoteStart")
    vote <- append ( vote, tmp )
    #
    ## pri
    url <- url( webpri[n], open="rt", encoding = "ISO-8859-1" )
    tmp<- readLines(url, warn=FALSE)
    close(url)
    tmp2 <- grep(tmp, pattern="Sentido del voto")
    tmp <- c( "emmPriVoteStart", tmp[(tmp2+1):length(tmp)] ) ## REMOVES JUNK TIL START OF NAMES LIST
    vote <- append ( vote, tmp )
    #
    ## prd
    url <- url( webprd[n], open="rt", encoding = "ISO-8859-1" )
    tmp<- readLines(url, warn=FALSE)
    close(url)
    tmp2 <- grep(tmp, pattern="Sentido del voto")
    tmp <- c( "emmPrdVoteStart", tmp[(tmp2+1):length(tmp)] ) ## REMOVES JUNK TIL START OF NAMES LIST
    vote <- append ( vote, tmp )
    #
    ## pt
    url <- url( webpt[n], open="rt", encoding = "ISO-8859-1" )
    tmp<- readLines(url, warn=FALSE)
    close(url)
    tmp2 <- grep(tmp, pattern="Sentido del voto")
    tmp <- c( "emmPtVoteStart", tmp[(tmp2+1):length(tmp)] ) ## REMOVES JUNK TIL START OF NAMES LIST
    vote <- append ( vote, tmp )
    #
    ## pvem
    url <- url( webpvem[n], open="rt", encoding = "ISO-8859-1" )
    tmp<- readLines(url, warn=FALSE)
    close(url)
    tmp2 <- grep(tmp, pattern="Sentido del voto")
    tmp <- c( "emmPvemVoteStart", tmp[(tmp2+1):length(tmp)] ) ## REMOVES JUNK TIL START OF NAMES LIST
    vote <- append ( vote, tmp )
    #
    ## conve
    url <- url( webconve[n], open="rt", encoding = "ISO-8859-1" )
    tmp<- readLines(url, warn=FALSE)
    close(url)
    tmp2 <- grep(tmp, pattern="Sentido del voto")
    tmp <- c( "emmConveVoteStart", tmp[(tmp2+1):length(tmp)] ) ## REMOVES JUNK TIL START OF NAMES LIST
    vote <- append ( vote, tmp )
    #
    ## panal
    url <- url( webpanal[n], open="rt", encoding = "ISO-8859-1" )
    tmp<- readLines(url, warn=FALSE)
    close(url)
    tmp2 <- grep(tmp, pattern="Sentido del voto")
    tmp <- c( "emmPanalVoteStart", tmp[(tmp2+1):length(tmp)] ) ## REMOVES JUNK TIL START OF NAMES LIST
    vote <- append ( vote, tmp )
    #
    ## indep
    url <- url( webindep[n], open="rt", encoding = "ISO-8859-1" )
    tmp<- readLines(url, warn=FALSE)
    close(url)
    tmp2 <- grep(tmp, pattern="Sentido del voto")
    tmp <- c( "emmIndepVoteStart", tmp[(tmp2+1):length(tmp)] ) ## REMOVES JUNK TIL START OF NAMES LIST
    vote <- append ( vote, tmp )
    ##
    write(vote, filenames[n])
    #paste("iteration =", n, "leg =", dat$leg[n], dat$filename[n])
    }
##
## SAVE INFOSIL FILENAMES INFO FOR USE IN NEW RC SYSTEMATIZATION
filenames <- newfilenames
save(filenames, file=paste(DipMex,"/infosilFilenames.RData",sep=""))
## END OF INFOSIL ROLL CALL DOWNLOAD





####OPCION 1 NO SEGUIDA
###n <- 2001
####for (n in 1:N){
###    tmp <- c(paste("fch =", dat$yr[n]*10000+dat$mo[n]*100+dat$dy[n]), paste("leg =",dat$leg[n]),
###                   sub(dat$filename[n], pattern="tabla", replacement=""), dat$title[n])
###    if (dat$favor[n] > 0)
###    { direc <- webayes[n]
###      url <- url(direc,open="rt")
###      tmp <- append(tmp, c("emmAyes", readLines(url, warn=FALSE)))
###      close(url) } else next
###    if (dat$contra[n] > 0)
###    { direc <- webnays[n]
###      url <- url(direc,open="rt")
###      tmp <- append(tmp, c("emmNays", readLines(url, warn=FALSE)))
###      close(url) } else next
###    if (dat$absten[n] > 0)
###    { direc <- webabsten[n]
###      url <- url(direc,open="rt")
###      tmp <- append(tmp, c("emmAbstentions", readLines(url, warn=FALSE)))
###      close(url) } else next
###    if (dat$quorum[n] > 0)
###    { direc <- webquorum[n]
###      url <- url(direc,open="rt")
###      tmp <- append(tmp, c("emmShowNoVote", readLines(url, warn=FALSE)))
###      close(url) } else next
###    if (dat$ausen[n] > 0)
###    { direc <- webausen[n]
###      url <- url(direc,open="rt")
###      tmp <- append(tmp, c("emmAbsences", readLines(url, warn=FALSE)))
###      close(url) } else next
###    #filename<-paste(DipMex, "/matweb/tablas/57/",tabs57[n],".txt",sep="")
###    #write.table(tmp, filename, sep="\t")
####    }

# SPOTS NUMBERS OUT OF SEQUENCE FOR EACH PERIODO
tmp <- sub(dat$filename, pattern="tabla", replacement="")
per <- sub(tmp, pattern="(.*)-.*", replacement="\\1")
num <- as.numeric(sub(tmp, pattern=".*-(.*)", replacement="\\1"))
leg <- dat$leg
#
tmp <- num[leg==57 & per=="2or1"]
max(tmp)
all <- 1:max(tmp)
brk572or1 <- setdiff(all,tmp)
tmp <- num[leg==57 & per=="2or2"]
max(tmp)
all <- 1:max(tmp)
brk572or2 <- setdiff(all,tmp)
tmp <- num[leg==57 & per=="3or1"]
max(tmp)
all <- 1:max(tmp)
brk573or1 <- setdiff(all,tmp)
tmp <- num[leg==57 & per=="3or2"]
max(tmp)
all <- 1:max(tmp)
brk573or2 <- setdiff(all,tmp)
tmp <- num[leg==58 & per=="1or1"]
max(tmp)
all <- 1:max(tmp)
brk581or1 <- setdiff(all,tmp)
tmp <- num[leg==58 & per=="1or2"]
max(tmp)
all <- 1:max(tmp)
brk581or2 <- setdiff(all,tmp)
tmp <- num[leg==58 & per=="2or1"]
max(tmp)
all <- 1:max(tmp)
brk582or1 <- setdiff(all,tmp)
tmp <- num[leg==58 & per=="2or2"]
max(tmp)
all <- 1:max(tmp)
brk582or2 <- setdiff(all,tmp)
tmp <- num[leg==58 & per=="3or1"]
max(tmp)
all <- 1:max(tmp)
brk583or1 <- setdiff(all,tmp)
tmp <- num[leg==58 & per=="3or2"]
max(tmp)
all <- 1:max(tmp)
brk583or2 <- setdiff(all,tmp)
tmp <- num[leg==59 & per=="1or1"]
max(tmp)
all <- 1:max(tmp)
brk591or1 <- setdiff(all,tmp)
tmp <- num[leg==59 & per=="1or2"]
max(tmp)
all <- 1:max(tmp)
brk591or2 <- setdiff(all,tmp)
tmp <- num[leg==59 & per=="2or1"]
max(tmp)
all <- 1:max(tmp)
brk592or1 <- setdiff(all,tmp)
tmp <- num[leg==59 & per=="2or2"]
max(tmp)
all <- 1:max(tmp)
brk592or2 <- setdiff(all,tmp)
tmp <- num[leg==59 & per=="3or1"]
max(tmp)
all <- 1:max(tmp)
brk593or1 <- setdiff(all,tmp)
tmp <- num[leg==59 & per=="3or2"]
max(tmp)
all <- 1:max(tmp)
brk593or2 <- setdiff(all,tmp)
tmp <- num[leg==60 & per=="1or1"]
max(tmp)
all <- 1:max(tmp)
brk601or1 <- setdiff(all,tmp)
tmp <- num[leg==60 & per=="1or2"]
max(tmp)
all <- 1:max(tmp)
brk601or2 <- setdiff(all,tmp)
tmp <- num[leg==60 & per=="2or1"]
max(tmp)
all <- 1:max(tmp)
brk602or1 <- setdiff(all,tmp)
tmp <- num[leg==60 & per=="2or2"]
max(tmp)
all <- 1:max(tmp)
brk602or2 <- setdiff(all,tmp)
tmp <- num[leg==60 & per=="3or1"]
max(tmp)
all <- 1:max(tmp)
brk603or1 <- setdiff(all,tmp)
tmp <- num[leg==60 & per=="3or2"]
max(tmp)
all <- 1:max(tmp)
brk603or2 <- setdiff(all,tmp)
#
brk572or1
brk572or2
brk573or1
brk573or2
brk581or1
brk581or2
brk582or1
brk582or2
brk583or1
brk583or2
brk591or1
brk591or2
brk592or1
brk592or2
brk593or1
brk593or2
brk601or1
brk601or2
brk602or1
brk602or2
brk603or1
brk603or2
#
#rm(all, leg, num, per)



