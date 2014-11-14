rm(list = ls())
#
## SET YOUR WORKING DIRECTORY HERE (SAVE DATA FILES IN THIS DIRECTORY)
workdir <- c("~/Dropbox/data/rollcall/dipMex/data")
#workdir <- c("d:/01/Dropbox/data/rollcall/dipMex")
setwd(workdir)

# if only loading saved data
load(file=paste(workdir, "votesForWeb", "rc61.RData", sep="/"))

## IMPORT DIPUTADO NAMES AND DISTRICTS (PREPARED IN EXCEL)
dipdat <- read.csv(paste(workdir, "/diputados/dip61.csv", sep = ""), header=TRUE, stringsAsFactors = FALSE)
dipdat$idOldDrop <- NULL # old IDs, no longer good
dipdat$edo <- dipdat$edoSIL <- NULL # redundant
#
id <- dipdat$id
names <- dipdat$nom
names.alt <- dipdat$nomregexp
pty <- dipdat$part

##########################
## 61 LEG FROM INFOSIL  ##
##########################

# Import filenames
load(paste(workdir, "infosilFilenames61.RData",sep="/"))
#
I <- length(filenames)
J <- nrow(dipdat)
#
tmp <- rep(NA, times=I)
votdat2 <- data.frame(favor = tmp, contra = tmp, absten = tmp, quorum = tmp, ausen = tmp,
                      title = NA, leg = rep(61, times = I),
                      filename = sub(filenames, pattern = ".*/61/(.*).txt", replacement = "\\1"),
                      yr = tmp, mo = tmp, dy = tmp, haveinfo = rep(1, times = I))
rc2 <- matrix(0,  nrow = I, ncol = J); rc2 <- as.data.frame(rc2); colnames(rc2) <- id

# determine character encoding # SHOULD LEARN TO DO WITH BEAUTIFUL SOUP
encod <- rep(NA, I)
for (i in 1:I){
    info <- readLines( con=filenames[i] , encoding = "utf8" ) 
    encod[i] <- ifelse( length(grep(info, pattern="Martínez", perl=TRUE))>0, "utf8", NA) # the name should appear in every file
}
for(i in which(is.na(encod)==TRUE)){
    info <- readLines( con=filenames[i] , encoding = "latin1" ) 
    encod[i] <- ifelse( length(grep(info, pattern="Martínez", perl=TRUE))>0, "latin1", NA) # the name should appear in every file
}
which(is.na(encod)==TRUE) # must be empty to proceed

i <- 1; j <- 1
for (i in 1:I){
    print(paste("loop", i, "of", I, "---", round(i*100/I, digits = 0), "percent"))
    info <- readLines( con=filenames[i] , encoding = encod[i] ) 
    votdat2$title[i] <- info[4]
    votdat2$dy[i] <- as.numeric(sub(info[1], pattern="fch = ([0-9]*)(-.*-)([0-9]*)", replacement="\\1"))
    votdat2$yr[i] <- as.numeric(sub(info[1], pattern="fch = ([0-9]*)(-.*-)([0-9]*)", replacement="\\3"))
    tmp <- sub(info[1], pattern="fch = ([0-9]*-)(.*)(-[0-9]*)", replacement="\\2")
    tmp <- sub(tmp, pattern="[Ee]nero", replacement="1")
    tmp <- sub(tmp, pattern="[Ff]ebrero", replacement="2")
    tmp <- sub(tmp, pattern="[Mm]arzo", replacement="3")
    tmp <- sub(tmp, pattern="[Aa]bril", replacement="4")
    tmp <- sub(tmp, pattern="[Mm]ayo", replacement="5")
    tmp <- sub(tmp, pattern="[Jj]unio", replacement="6")
    tmp <- sub(tmp, pattern="[Jj]ulio", replacement="7")
    tmp <- sub(tmp, pattern="[Aa]gosto", replacement="8")
    tmp <- sub(tmp, pattern="[Ss]eptiembre", replacement="9")
    tmp <- sub(tmp, pattern="[Oo]ctubre", replacement="10")
    tmp <- sub(tmp, pattern="[Nn]oviembre", replacement="11")
    tmp <- sub(tmp, pattern="[Dd]iciembre", replacement="12")
    votdat2$mo[i] <- as.numeric(tmp)
    #
    ## NEEDED IF DEPUTY'S PARTY WILL BE CHECKED
    #panstart <- grep(info, pattern="emmPanVoteStart"); pristart <- grep(info, pattern="emmPriVoteStart")
    #prdstart <- grep(info, pattern="emmPrdVoteStart"); ptstart <- grep(info, pattern="emmPtVoteStart")
    #pvemstart <- grep(info, pattern="emmPvemVoteStart"); convestart <- grep(info, pattern="emmConveVoteStart")
    #panalstart <- grep(info, pattern="emmPanalVoteStart"); indepstart <- grep(info, pattern="emmIndepVoteStart")
    #
    for (j in 1:J){
        tmp <- grep(info, pattern=dipdat$nomregexp[j], perl = TRUE) # DIP'S NAME
        tmp2 <- ifelse( length(tmp)>0, sub(info[tmp+1], pattern=".*<span class.*> (.*)</span></td>", replacement="\\1"), 0)
        tmp2 <- gsub(tmp2, pattern="A favor", replacement="1")
        tmp2 <- gsub(tmp2, pattern="En contra", replacement="2")
        tmp2 <- gsub(tmp2, pattern="Abstención", replacement="3")
        tmp2 <- gsub(tmp2, pattern="Sólo asistencia", replacement="4")
        tmp2 <- gsub(tmp2, pattern="Ausente", replacement="5")
        rc2[i,j] <- as.numeric(tmp2)
    }
    tmp <- (( ( 1:(J/2) )*2 )-1) # sequence of propietarios assuming suplente is next obs
    for (j in tmp){
        if (rc2[i,j]==0 & rc2[i,j+1]==0) {rc2[i,j] <- 6} else next
    }
}

save.image("tmp.RData") # debug
load("tmp.RData")  # debug

    ## excepciones
    ##
    rc2[votdat2$yr==2010 & votdat2$mo<3, id=="ags03p"] <- 5 ## (CUADRA LICENCIA, SUPLENTE TARDA)
    rc2[votdat2$yr==2010 & votdat2$mo==3 & votdat2$dy<4, id=="ags03p"] <- 5 ## (CUADRA LICENCIA, SUPLENTE TARDA)
    rc2[votdat2$yr==2009, id=="c1rp41p"] <- 5 ## (PAN IMPUGNÓ SU NACIONALIDAD Y JURÓ HASTA 9/2/2010; EN SIL APARECE NOMBRE DE SU HERMANA, AUSENTE)
    rc2[votdat2$yr==2010 & votdat2$mo==12 & votdat2$dy==2, id=="coa04p"] <- 5 ## (MOREIRA LICENCIA, SUPLENTE TARDA)
    rc2[votdat2$yr==2011 & votdat2$mo==2 & votdat2$dy==10, id=="coa05p"] <- 5 ## (RIQUELME LICENCIA, SUPLENTE TARDA)
    rc2[votdat2$yr==2011 & votdat2$mo==11 & votdat2$dy>=24, id=="c2rp07p"] <- 0 ## (GARZA FLORES LICENCIA, SU PROPIETARIO NO PARECE VOLVER)
    rc2[votdat2$yr==2011 & votdat2$mo==12,                  id=="c2rp07p"] <- 0 ## (GARZA FLORES LICENCIA, SU PROPIETARIO NO PARECE VOLVER)
    rc2[votdat2$yr==2011 & votdat2$mo==8 & votdat2$dy==31, id=="cps08p"] <- 5 ## (ALBORES NO APARECE ESTE DIA)
    rc2[votdat2$yr==2009, id=="c3rp09p"] <- 5 ## (JUANITA, SUPLENTE TARDA)
    rc2[votdat2$yr==2010 & votdat2$mo==3 & votdat2$dy==16, id=="c3rp13p"] <- 5 ## (GIL ZUARTH LICENCIA, SUPLENTE TARDA)
    rc2[votdat2$yr==2009 & votdat2$mo==12 & votdat2$dy==15, id=="cua02p"] <- 5 ## (MURGUIA ABSENT BUT NOT IN INFOPAL)
    rc2[votdat2$yr==2010 & votdat2$mo==10 & votdat2$dy>=5 & votdat2$dy<=12 , id=="c1rp11p"] <- 5 ## (ORTIZ GLEZ LICENCIA, SUPLENTE TARDA)
    rc2[votdat2$yr==2011 & votdat2$mo==3 & votdat2$dy>=23 & votdat2$dy<=29 , id=="c1rp12p"] <- 5 ## (ZAMBRANO LICENCIA, SUPLENTE TARDA)
    rc2[votdat2$yr==2011 & votdat2$mo==3 & votdat2$dy==31, id=="c4rp06p"] <- 5 ## (ENCINAS LICENCIA, SUPLENTE TARDA)
    rc2[votdat2$yr==2010 & votdat2$mo==2 & votdat2$dy==11, id=="c1rp13p"] <- 5 ## (SILERIO JUANITA, SUPLENTE TARDA)
    rc2[votdat2$yr==2010 & votdat2$mo==9 & votdat2$dy>=3, id=="gua01p"] <- 5 ## HUERTA LICENCIA, SUPLENTE TARDA
    rc2[votdat2$yr==2010 & votdat2$mo==4 & votdat2$dy==29, id=="gua02p"] <- 5 ## PASCUALLI ATAQUE CARDIACO EN PLENA SESION
    rc2[votdat2$yr==2010 & votdat2$mo==10 & votdat2$dy==7, id=="c2rp14p"] <- 5 ## (TIPO DESAPARECE 3 VOTOS ENTRE LARGA SERIE DE AUSENCIAS, SUPLENTE TARDA)
    rc2[votdat2$yr==2010 & votdat2$mo==10 & votdat2$dy==12, id=="c2rp14p"] <- 5 ## (TIPO DESAPARECE 3 VOTOS ENTRE LARGA SERIE DE AUSENCIAS, SUPLENTE TARDA)
    rc2[votdat2$yr==2011 & votdat2$mo==9 & votdat2$dy==27, id=="c2rp12p"] <- 0 ## (REYNOSO LICENCIA, SUPLENTE TARDA)
    rc2[votdat2$yr==2011 & votdat2$mo==3 & votdat2$dy==29, id=="gue05p"] <- 0 ## (RMZ HDZ SOFIO LICENCIA, SUPLENTE TARDA)
    rc2[votdat2$yr==2011 & votdat2$mo==9 & votdat2$dy>=4, id=="gue05p"] <- 0 ## (VILLANUEVA ASESINADO, PROPIETARIO REGRESA TARDE)
    rc2[votdat2$yr==2011 & votdat2$mo>=10 & votdat2$mo<=11, id=="gue05p"] <- 0 ## (VILLANUEVA ASESINADO, PROPIETARIO REGRESA TARDE)
    rc2[votdat2$yr==2011 & votdat2$mo==12 & votdat2$dy<13, id=="gue05p"] <- 0 ## (VILLANUEVA ASESINADO, PROPIETARIO REGRESA TARDE)
    rc2[votdat2$yr==2011 & votdat2$mo==12 & votdat2$dy>=13, id=="gue05p"] <- 5 ## (VILLANUEVA ASESINADO, PROPIETARIO REGRESA TARDE)
    rc2[votdat2$yr==2010 & votdat2$mo==4 & votdat2$dy==29, id=="hgo05p"] <- 5 ## (RMZ VALTIERRA LICENCIA, SUPLENTE NUNCA ASUME, LUEGO VUELVE)
    rc2[votdat2$yr==2011 & votdat2$mo==3 & votdat2$dy>=23, id=="hgo05p"] <- 5 ## (RMZ VALTIERRA 2a LICENCIA, SUPLENTE TARDA)
    rc2[votdat2$yr==2011 & votdat2$mo==4, id=="hgo05p"] <- 5                  ## (RMZ VALTIERRA 2a LICENCIA, SUPLENTE TARDA)
    rc2[votdat2$yr==2011 & votdat2$mo==10 & votdat2$dy>=4 & votdat2$dy<18, id=="mex02p"] <- 0  ## (DOMINGUEZ REX LICENCIA, SUPLENTE NO JURA)
    rc2[votdat2$yr==2011 & votdat2$mo>=9, id=="c4rp01p"] <- 0  ## (JVM LICENCIA, SUPLENTE NO JURA)
    rc2[votdat2$yr==2011 & votdat2$mo==3 & votdat2$dy>=16 & votdat2$dy<18, id=="c4rp02p"] <- 5  ## (GUERRERO RUBIO LICENCIA, SUPLENTE NO JURA)
    rc2[votdat2$yr==2011 & votdat2$mo==4 & votdat2$dy>=5 & votdat2$dy<=13, id=="c5rp19p"] <- 5  ## (OCHOA MEJIA LICENCIA, SUPLENTE NO JURA)
    rc2[votdat2$yr==2011 & votdat2$mo==3 & votdat2$dy==31, id=="c5rp03p"] <- 5 ## (GLEZ YAÑEZ LICENCIA, SUPLENTE NO JURA)
    rc2[votdat2$yr==2011 & votdat2$mo==4 & votdat2$dy<27, id=="c5rp03p"] <- 5  ## (GLEZ YAÑEZ LICENCIA, SUPLENTE NO JURA)
    rc2[votdat2$yr==2009, id=="mic01p"] <- 5  ## (GODOY JURA TARDE, SUPLENTE NO LLEGA; GODOY PIERDE FUERO)
    rc2[votdat2$yr==2010 & votdat2$mo<=8, id=="mic01p"] <- 5  ## (GODOY JURA TARDE, SUPLENTE NO LLEGA; GODOY PIERDE FUERO)
    rc2[votdat2$yr==2010 & votdat2$mo==9 & votdat2$dy<23, id=="mic01p"] <- 5  ## (GODOY JURA TARDE, SUPLENTE NO LLEGA; GODOY PIERDE FUERO)
    rc2[votdat2$yr==2011 & votdat2$mo==8 & votdat2$dy==31, id=="mic05p"] <- 5  ## (TIPO NO LLEGA ESE DIA)
    rc2[votdat2$yr==2011 & votdat2$mo==8 & votdat2$dy==31, id=="mic08p"] <- 5  ## (TIPO NO LLEGA ESE DIA)
    rc2[votdat2$yr==2011 & votdat2$mo==3 & votdat2$dy==9, id=="mic11p"] <- 5  ## (BAEZ CEJA LICENCIA, SUPLENTE TARDA)
    rc2[votdat2$yr==2010 & votdat2$mo==8 & votdat2$dy>=14, id=="c5rp39p"] <- 5  ## DE LOS REYES LICENCIA, SUPLENTE TARDA
    rc2[votdat2$yr==2010 & votdat2$mo==9 & votdat2$dy<7, id=="c5rp39p"] <- 5  ## DE LOS REYES LICENCIA, SUPLENTE TARDA
    rc2[votdat2$yr==2011 & votdat2$mo==3 & votdat2$dy==9, id=="c5rp33p"] <- 5  ## (TORRES PIÑA LICENCIA, SUPLENTE TARDA)
    rc2[votdat2$yr==2010 & votdat2$mo==10 & votdat2$dy>=11, id=="mor05p"] <- 5  ## (SANCHEZ VELEZ LICENCIA, SUPLENTE NO JURA)
    rc2[votdat2$yr==2010 & votdat2$mo==11 & votdat2$dy<7, id=="mor05p"] <- 5  ## (SANCHEZ VELEZ LICENCIA, SUPLENTE NO JURA)
    rc2[votdat2$yr==2010 & votdat2$mo==9 & votdat2$dy>=3, id=="c3rp15p"] <- 5  ## ZAVALETA FALLECE
    rc2[votdat2$yr==2011 & votdat2$mo==2 & votdat2$dy>=1 & votdat2$dy<8, id=="c4rp03p"] <- 5  ## (RMZ REGORDOSA LICENCIA, SUPLENTE TARDA)
    rc2[votdat2$yr==2011 & votdat2$mo==4 & votdat2$dy>=6 & votdat2$dy<=7, id=="qui02p"] <- 5  ## (ORTIZ YELADAQUI LICENCIA, SUPLENTE TARDA)
    rc2[votdat2$yr==2010, id=="c2rp29p"] <- 5  ## (JUANITA)
    rc2[votdat2$yr==2010 & votdat2$mo==4 & votdat2$dy>=6, id=="sin08p"] <- 5  ## (GARCIA GRANADOS LICENCIA, SUPLENTE TARDA)
    rc2[votdat2$yr==2010 & votdat2$mo>4 & votdat2$mo<7, id=="sin08p"] <- 5    ## (GARCIA GRANADOS LICENCIA, SUPLENTE TARDA)
    rc2[votdat2$yr==2010 & votdat2$mo==2 & votdat2$dy>=23 & votdat2$dy<=25, id=="tam02p"] <- 5  ## (VILLARREAL SALINAS LICENCIA, SUPLENTE TARDA)
    rc2[votdat2$yr==2010 & votdat2$mo==1 & votdat2$dy>=30, id=="tam05p"] <- 5  ## (TORRE CANTU LICENCIA, SUPLENTE TARDA)
    rc2[votdat2$yr==2010 & votdat2$mo>=2, id=="tam05p"] <- 5                  ## (TORRE CANTU LICENCIA, SUPLENTE TARDA)
    rc2[votdat2$yr==2010 & votdat2$mo==3 & votdat2$dy>=1 & votdat2$dy<26, id=="ver11p"] <- 5  ## (GARCIA BRINGAS LICENCIA, SUPLENTE NO JURA)
    rc2[votdat2$yr==2010 & votdat2$mo==3 & votdat2$dy==23, id=="ver12p"] <- 5  ## (GUDIÑO CORRO LICENCIA, SUPLENTE TARDA)
    rc2[votdat2$yr==2011 & votdat2$mo==10 & votdat2$dy>=11 & votdat2$dy<13, id=="ver13p"] <- 0  ## (FLORES ESPINOSA LICENCIA, SUPLENTE TARDA)
    rc2[votdat2$yr==2010 & votdat2$mo==12 & votdat2$dy>=1 & votdat2$dy<7, id=="ver17p"] <- 5  ## (CARRILLO SANCHEZ LICENCIA, SUPLENTE NO JURA)
    rc2[votdat2$yr==2010 & votdat2$mo==4 & votdat2$dy>=14 & votdat2$dy<20, id=="c3rp32p"] <- 5  ## (SALDAÑA MORAN LICENCIA, SUPLENTE NO JURA)
    rc2[votdat2$yr>=2011, id=="tam05p"] <- 5 ## (TAM05 VACANT SINCE 1/1/2011)
    rc2[votdat2$yr==2011 & votdat2$mo==12 & votdat2$dy==15, id=="yuc04p"] <- 0  ## (ZAPATA BELLO LICENCIA, SUPLENTE TARDA)
    #
    rc2[votdat2$yr==2012 & votdat2$mo==2 & votdat2$dy<=9, id=="cam02p"] <- 0 ## (LICENCIA, SUPLENTE TARDA)
    rc2[votdat2$yr==2011 & votdat2$mo==8 & votdat2$dy==31, id=="cps08p"] <- 5 ## (ALBORES NO APARECE ESTE DIA)
    rc2[votdat2$yr==2012 & votdat2$mo==1 & votdat2$dy>20, id=="cps08p"] <- 5 ## (ALBORES LICENCIA)
    rc2[votdat2$yr==2012 & votdat2$mo>1, id=="cps08p"] <- 5 ## (ALBORES LICENCIA)
    rc2[votdat2$yr==2012 & votdat2$mo==2  & votdat2$dy<=14, id=="hgo01p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=10, id=="hgo01p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==2  & votdat2$dy<=9, id=="jal02p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==2  & votdat2$dy<=14, id=="jal04p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==2  , id=="jal07p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==3  & votdat2$dy==1, id=="jal07p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==2  & votdat2$dy<=23, id=="jal09p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==2  , id=="jal12p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==3  & votdat2$dy==1, id=="jal12p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==2  & votdat2$dy<=14, id=="mor01p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==2  & votdat2$dy<=9, id=="nay01p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==2  & votdat2$dy<=23, id=="nl05p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==2  & votdat2$dy<=16, id=="oax01p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==2  & votdat2$dy<=14, id=="oax05p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==2  & votdat2$dy<=14, id=="pue08p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==2  & votdat2$dy<=16, id=="san02p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==2  & votdat2$dy<=16, id=="san03p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==2, id=="tab02p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==3  & votdat2$dy<=20, id=="tab02p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo>=2, id=="ver02p"] <- 0 ## mejía
    rc2[votdat2$yr==2012 & votdat2$mo>=2, id=="ver02p"] <- 0 ## mejía
    rc2[votdat2$yr==2011 & votdat2$mo==11 & votdat2$dy>=24, id=="c2rp07p"] <- 0 ## (GARZA FLORES LICENCIA, SU PROPIETARIO NO PARECE VOLVER)
    rc2[votdat2$yr==2011 & votdat2$mo==12,                  id=="c2rp07p"] <- 0 ## (GARZA FLORES LICENCIA, SU PROPIETARIO NO PARECE VOLVER)
    rc2[votdat2$yr==2012 & votdat2$mo>=2, id=="c2rp07p"] <- 0 ## (GARZA FLORES LICENCIA, SU PROPIETARIO NO PARECE VOLVER)
    rc2[votdat2$yr==2012 & votdat2$mo<4, id=="c3rp09p"] <- 0 ## (JUANITA REGRESA)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy<=17, id=="c3rp09p"] <- 0 ## (JUANITA REGRESA)
    rc2[votdat2$yr==2011 & votdat2$mo>=9, id=="c4rp01p"] <- 0  ## (JVM LICENCIA, SUPLENTE NO JURA)
    rc2[votdat2$yr==2012 & votdat2$mo>=2, id=="c4rp01p"] <- 0 ## (JVM)
    rc2[votdat2$yr==2012 & votdat2$mo>=2, id=="c4rp01p"] <- 0 ## (JVM)
    rc2[votdat2$yr==2012 & votdat2$mo==2  & votdat2$dy<16, id=="c4rp13p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=9, id=="c4rp13p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo>=2, id=="c4rp40p"] <- 0 ## (Beto)
    rc2[votdat2$yr==2012 & votdat2$mo>=2, id=="c4rp40p"] <- 0 ## (Beto)
    rc2[votdat2$yr==2012 & votdat2$mo==2 & votdat2$dy<=9, id=="coa03p"] <- 0 ## (LICENCIA, SUPLENTE TARDA)
    rc2[votdat2$yr==2012 & votdat2$mo==2  & votdat2$dy>=14, id=="gue08p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo>2, id=="gue08p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==2  & votdat2$dy>=14 & votdat2$dy<=16, id=="nl07p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==2  & votdat2$dy>=16 & votdat2$dy<=23, id=="pue02p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==3 & votdat2$dy<27, id=="cps01p"] <- 0 ## (LICENCIA TEMPORAL, SUPLENTE TARDA)
    rc2[votdat2$yr==2012 & votdat2$mo==3  & votdat2$dy>=6 & votdat2$dy<=20, id=="son04p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==3  & votdat2$dy>=6, id=="son05p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==3  & votdat2$dy>=6, id=="c1rp30p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2010 & votdat2$mo==12 & votdat2$dy==2, id=="coa04p"] <- 5 ## (MOREIRA LICENCIA, SUPLENTE TARDA)
    rc2[votdat2$yr==2012 & votdat2$mo==3 & votdat2$dy>=13, id=="coa04p"] <- 0 ## (SUPLENTE MOREIRA PIDE LICENCIA)
    rc2[votdat2$yr==2012 & votdat2$mo>3, id=="coa04p"] <- 0 ## (SUPLENTE MOREIRA PIDE LICENCIA)
    rc2[votdat2$yr==2012 & votdat2$mo==3 & votdat2$dy>=13, id=="coa04s"] <- 0 ## (SUPLENTE MOREIRA PIDE LICENCIA)
    rc2[votdat2$yr==2012 & votdat2$mo>3, id=="coa04s"] <- 0 ## (SUPLENTE MOREIRA PIDE LICENCIA)
    rc2[votdat2$yr==2012 & votdat2$mo==3  & votdat2$dy>=13 & votdat2$dy<=20, id=="mor02p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==3  & votdat2$dy>=13 & votdat2$dy<=20, id=="mor03p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==3  & votdat2$dy>=28, id=="mor03p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4, id=="mor03p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==3  & votdat2$dy>=6, id=="son06p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==3  & (votdat2$dy==15 | votdat2$dy==20), id=="gue04p"] <- 0 ## (MISSING)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=24, id=="gue04p"] <- 0 ## (LICENCIA)
    rc2[votdat2$yr==2012 & votdat2$mo==3  & votdat2$dy>=20, id=="gue09p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy==30, id=="gue09p"] <- 0 ## (SUPLENTE TARDA)
    rc2[votdat2$yr==2012 & votdat2$mo==3 & votdat2$dy>=13, id=="c2rp08p"] <- 0 ## (LICENCIA, SUPLENTE TARDA)
    rc2[votdat2$yr==2012 & votdat2$mo==3  & votdat2$dy>=27, id=="df06p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==3  & votdat2$dy>=27, id=="gue02p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4, id=="gue02p"] <- 0 ## (LICENCIA SUPLENTE TARDA)
    rc2[votdat2$yr==2012 & votdat2$mo==3  & votdat2$dy>=27, id=="gue07p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy<=26, id=="gue07p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==3  & votdat2$dy>=27, id=="c4rp15p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==3  & votdat2$dy>=28, id=="c1rp36p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4, id=="c1rp36p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==3 & votdat2$dy>=29, id=="cps06p"] <- 0 ## (LICENCIA, SUPLENTE NO ASUME)
#    rc2[votdat2$yr==2012 & votdat2$mo>3, id=="cps06p"] <- 0 ## (LICENCIA, SUPLENTE NO ASUME)
    rc2[votdat2$yr==2012 & votdat2$mo==3 & votdat2$dy>=29, id=="cps06p"] <- 0 ## (LICENCIA, SUPLENTE TARDA)
    rc2[votdat2$yr==2012 & votdat2$mo==4 & votdat2$dy<=26, id=="cps06p"] <- 0 ## (LICENCIA, SUPLENTE TARDA)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy<=17, id=="mex34p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==3  & votdat2$dy>=29, id=="mex34p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
#    rc2[votdat2$yr==2012 & votdat2$mo==4, id=="mex34p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=10, id=="df23p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=10, id=="df23p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=10, id=="mex05p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
#    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=10 & votdat2$dy<=12, id=="mex07p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=10, id=="mex07p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=10 & votdat2$dy<=12, id=="mex08p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
#    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=10, id=="mex08p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy==17, id=="mex08p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=10 & votdat2$dy<=12, id=="mex12p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=27, id=="mex12p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=10 & votdat2$dy<=17, id=="mex13p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=10 & votdat2$dy<=17, id=="mex13p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy==30, id=="mex13p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=10 & votdat2$dy<=12, id=="mex14p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=27, id=="mex14p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=24 & votdat2$dy<=26, id=="mex15p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=10 & votdat2$dy<=17, id=="mex16p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy==30, id=="mex16p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
#    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=10 & votdat2$dy<17, id=="mex17p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=10, id=="mex17p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=10, id=="mex19p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=10 & votdat2$dy<17, id=="mex20p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy==30, id=="mex20p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=10, id=="mex22p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
#    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=10 & votdat2$dy<=24, id=="mex22p"] <- 0 ## (LICENCIA SUPLENTE TARDE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=10, id=="mex23p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
#    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=10 & votdat2$dy<17, id=="mex23p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=10, id=="mex25p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
#    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=10 & votdat2$dy<17, id=="mex25p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=10, id=="mex26p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
#    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=10 & votdat2$dy<17, id=="mex26p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=10 & votdat2$dy<=24, id=="mex29p"] <- 0 ## (LICENCIA SUPLENTE TARDA)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=10, id=="mex30p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=10, id=="mex32p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=10, id=="mex35p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=10, id=="mex36p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=10 & votdat2$dy<17, id=="mex37p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy==30, id=="mex37p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=10, id=="mex38p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=10, id=="mex39p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=10, id=="ver03p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=10, id=="c2rp38p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=10, id=="c3rp08p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=10, id=="c5rp05p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=11, id=="que03p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
#    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=11 & votdat2$dy<=26, id=="que03p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=12, id=="que04p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
#    rc2[votdat2$yr==2011 & votdat2$mo==8 & votdat2$dy==31, id=="mic05p"] <- 5  ## (TIPO NO LLEGA ESE DIA)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy==17, id=="mic05p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy==17, id=="mic05p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=17 & votdat2$dy<=24, id=="c1rp21p"] <- 0 ## (LICENCIA SUPLENTE TARDA)
#    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=17, id=="c2rp13p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=17 & votdat2$dy<=19, id=="c2rp13p"] <- 0 ## (LICENCIA SUPLENTE TARDA)
#    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy==17, id=="c4rp35p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy==17 & votdat2$dy<=19, id=="c4rp35p"] <- 0 ## (LICENCIA SUPLENTE TARDA)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=24, id=="gua09p"] <- 0 ## (LICENCIA SUPLENTE TARDA)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=24 & votdat2$dy<=25, id=="jal10p"] <- 0 ## (LICENCIA SUPLENTE TARDA)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=24, id=="c4rp33p"] <- 0 ## (LICENCIA SUPLENTE TARDA)
#    rc2[votdat2$yr==2011 & votdat2$mo==3 & votdat2$dy==31, id=="c5rp03p"] <- 5 ## (GLEZ YAÑEZ LICENCIA, SUPLENTE NO JURA)
#    rc2[votdat2$yr==2011 & votdat2$mo==4 & votdat2$dy<27, id=="c5rp03p"] <- 5  ## (GLEZ YAÑEZ LICENCIA, SUPLENTE NO JURA)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=24   & votdat2$dy<=30, id=="c5rp03p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=26  & votdat2$dy<=30, id=="c4rp29p"] <- 0 ## (LICENCIA SUPLENTE TARDA)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=25, id=="c4rp37p"] <- 0 ## (LICENCIA SUPLENTE TARDA)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=27, id=="gue06p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=26, id=="mex04p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=27, id=="c4rp28p"] <- 0 ## (LICENCIA SUPLENTE TARDA)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy==30, id=="jal11p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy==30, id=="c5rp11p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    #
    rc2[votdat2$yr<=2011                                , id=="c5rp41p"] <- 0  ## Alemán Olvera llamada a remplazar RP tarde (entra su supente)
    rc2[votdat2$yr==2012 & votdat2$mo<3                 , id=="c5rp41p"] <- 0  ## Alemán Olvera llamada a remplazar RP tarde (entra su supente)
    rc2[votdat2$yr==2012 & votdat2$mo==3 & votdat2$dy<28, id=="c5rp41p"] <- 0  ## Alemán Olvera llamada a remplazar RP tarde (entra su supente)
    rc2[votdat2$yr<=2011                                , id=="c3rp41p"] <- 0  ## González Hernández llamada a remplazar RP tarde
    rc2[votdat2$yr==2012 & votdat2$mo<4                 , id=="c3rp41p"] <- 0  ## González Hernández llamada a remplazar RP tarde
    rc2[votdat2$yr==2012 & votdat2$mo==4 & votdat2$dy<17, id=="c3rp41p"] <- 0  ## González Hernández llamada a remplazar RP tarde
    rc2[votdat2$yr>=2010                                , id=="c1rp26p"] <- 0  ## Laura Ledesma licencia, suplente no entra, sustituto tarda
    #
## # THESE EXCEPTIONS ARE MOST LIKELY REDUNDANT, BUT ONE OR TWO MAY STILL BE OF USE... IF NEXT TIME CODE RUNS LEAVES NO 6s, DROP (ADDED 23OCT2014)
##     rc2[votdat2$yr==2010 & votdat2$mo<3, id=="ags03p"] <- 5 ## (CUADRA LICENCIA, SUPLENTE TARDA)
##     rc2[votdat2$yr==2010 & votdat2$mo==3 & votdat2$dy<4, id=="ags03p"] <- 5 ## (CUADRA LICENCIA, SUPLENTE TARDA)
##     rc2[votdat2$yr==2009, id=="c1rp41p"] <- 5 ## (PAN IMPUGNÓ SU NACIONALIDAD Y JURÓ HASTA 9/2/2010; EN SIL APARECE NOMBRE DE SU HERMANA, AUSENTE)
##     rc2[votdat2$yr==2011 & votdat2$mo==2 & votdat2$dy==10, id=="coa05p"] <- 5 ## (RIQUELME LICENCIA, SUPLENTE TARDA)
##     rc2[votdat2$yr==2010 & votdat2$mo==3 & votdat2$dy==16, id=="c3rp13p"] <- 5 ## (GIL ZUARTH LICENCIA, SUPLENTE TARDA)
##     rc2[votdat2$yr==2010 & votdat2$mo==10 & votdat2$dy>=5 & votdat2$dy<=12 , id=="c1rp11p"] <- 5 ## (ORTIZ GLEZ LICENCIA, SUPLENTE TARDA)
##     rc2[votdat2$yr==2011 & votdat2$mo==3 & votdat2$dy>=23 & votdat2$dy<=29 , id=="c1rp12p"] <- 5 ## (ZAMBRANO LICENCIA, SUPLENTE TARDA)
##     rc2[votdat2$yr==2011 & votdat2$mo==3 & votdat2$dy==31, id=="c4rp06p"] <- 5 ## (ENCINAS LICENCIA, SUPLENTE TARDA)
##     rc2[votdat2$yr==2010 & votdat2$mo==2 & votdat2$dy==11, id=="c1rp13p"] <- 5 ## (SILERIO JUANITA, SUPLENTE TARDA)
##     rc2[votdat2$yr==2010 & votdat2$mo==9 & votdat2$dy>=3, id=="gua01p"] <- 5 ## HUERTA LICENCIA, SUPLENTE TARDA
##     rc2[votdat2$yr==2010 & votdat2$mo==4 & votdat2$dy==29 & votdat2$filename=="61yr1or2-sil-124", id=="gua02p"] <- 5 ## PASCUALLI ATAQUE CARDIACO EN PLENA SESION
## #    rc2[votdat2$yr==2010 & votdat2$mo==10 & votdat2$dy==12, id=="c2rp14p"] <- 5 ## (TIPO DESAPARECE 3 VOTOS ENTRE LARGA SERIE DE AUSENCIAS, SUPLENTE TARDA)
##     rc2[votdat2$yr==2011 & votdat2$mo==9 & votdat2$dy==27, id=="c2rp12p"] <- 0 ## (REYNOSO LICENCIA, SUPLENTE TARDA)
##     rc2[votdat2$yr==2011 & votdat2$mo==3 & votdat2$dy==29, id=="gue05p"] <- 0 ## (RMZ HDZ SOFIO LICENCIA, SUPLENTE TARDA)
##     rc2[votdat2$yr==2011 & votdat2$mo==9 & votdat2$dy>=4, id=="gue05p"] <- 0 ## (VILLANUEVA ASESINADO, PROPIETARIO REGRESA TARDE)
##     rc2[votdat2$yr==2011 & votdat2$mo>=10 & votdat2$mo<=11, id=="gue05p"] <- 0 ## (VILLANUEVA ASESINADO, PROPIETARIO REGRESA TARDE)
##     rc2[votdat2$yr==2011 & votdat2$mo==12 & votdat2$dy<13, id=="gue05p"] <- 0 ## (VILLANUEVA ASESINADO, PROPIETARIO REGRESA TARDE)
##     rc2[votdat2$yr==2011 & votdat2$mo==12 & votdat2$dy>=13, id=="gue05p"] <- 5 ## (VILLANUEVA ASESINADO, PROPIETARIO REGRESA TARDE)
##     rc2[votdat2$yr==2010 & votdat2$mo==4 & votdat2$dy==29, id=="hgo05p"] <- 5 ## (RMZ VALTIERRA LICENCIA, SUPLENTE NUNCA ASUME, LUEGO VUELVE)
##     rc2[votdat2$yr==2011 & votdat2$mo==3 & votdat2$dy>=29, id=="hgo05p"] <- 5 ## (RMZ VALTIERRA 2a LICENCIA, SUPLENTE TARDA)
##     rc2[votdat2$yr==2011 & votdat2$mo==4, id=="hgo05p"] <- 5                 ## (RMZ VALTIERRA 2a LICENCIA, SUPLENTE TARDA)
##     rc2[votdat2$yr==2011 & votdat2$mo==10 & votdat2$dy>=4 & votdat2$dy<18, id=="mex02p"] <- 0  ## (DOMINGUEZ REX LICENCIA, SUPLENTE NO JURA)
##     rc2[votdat2$yr==2011 & votdat2$mo==3 & votdat2$dy>=16 & votdat2$dy<18, id=="c4rp02p"] <- 5  ## (GUERRERO RUBIO LICENCIA, SUPLENTE NO JURA)
##     rc2[votdat2$yr==2011 & votdat2$mo==4 & votdat2$dy>=5 & votdat2$dy<=13, id=="c5rp19p"] <- 5  ## (OCHOA MEJIA LICENCIA, SUPLENTE NO JURA)
##     rc2[votdat2$yr==2009, id=="mic01p"] <- 5  ## (GODOY JURA TARDE, SUPLENTE NO LLEGA; GODOY PIERDE FUERO)
##     rc2[votdat2$yr==2010 & votdat2$mo<=8, id=="mic01p"] <- 5  ## (GODOY JURA TARDE, SUPLENTE NO LLEGA; GODOY PIERDE FUERO)
##     rc2[votdat2$yr==2010 & votdat2$mo==9 & votdat2$dy<23, id=="mic01p"] <- 5  ## (GODOY JURA TARDE, SUPLENTE NO LLEGA; GODOY PIERDE FUERO)
##     rc2[votdat2$yr==2011 & votdat2$mo==8 & votdat2$dy==31, id=="mic08p"] <- 5  ## (TIPO NO LLEGA ESE DIA)
##     rc2[votdat2$yr==2011 & votdat2$mo==3 & votdat2$dy==9, id=="mic11p"] <- 5  ## (BAEZ CEJA LICENCIA, SUPLENTE TARDA)
##     rc2[votdat2$yr==2010 & votdat2$mo==8 & votdat2$dy>=14, id=="c5rp39p"] <- 5  ## DE LOS REYES LICENCIA, SUPLENTE TARDA
##     rc2[votdat2$yr==2010 & votdat2$mo==9 & votdat2$dy<7, id=="c5rp39p"] <- 5  ## DE LOS REYES LICENCIA, SUPLENTE TARDA
##     rc2[votdat2$yr==2011 & votdat2$mo==3 & votdat2$dy==9, id=="c5rp33p"] <- 5  ## (TORRES PIÑA LICENCIA, SUPLENTE TARDA)
##     rc2[votdat2$yr==2010 & votdat2$mo==10 & votdat2$dy>=11, id=="mor05p"] <- 5  ## (SANCHEZ VELEZ LICENCIA, SUPLENTE NO JURA)
##     rc2[votdat2$yr==2010 & votdat2$mo==11 & votdat2$dy<7, id=="mor05p"] <- 5  ## (SANCHEZ VELEZ LICENCIA, SUPLENTE NO JURA)
##     rc2[votdat2$yr==2010 & votdat2$mo==9 & votdat2$dy>=3, id=="c3rp15p"] <- 5  ## ZAVALETA FALLECE
##     rc2[votdat2$yr==2011 & votdat2$mo==2 & votdat2$dy>=1 & votdat2$dy<8, id=="c4rp03p"] <- 5  ## (RMZ REGORDOSA LICENCIA, SUPLENTE TARDA)
##     rc2[votdat2$yr==2011 & votdat2$mo==4 & votdat2$dy>=6 & votdat2$dy<=7, id=="qui02p"] <- 5  ## (ORTIZ YELADAQUI LICENCIA, SUPLENTE TARDA)
##     rc2[votdat2$yr==2010, id=="c2rp29p"] <- 5  ## (JUANITA)
##     rc2[votdat2$yr==2010 & votdat2$mo==4 & votdat2$dy>=6, id=="sin08p"] <- 5  ## (GARCIA GRANADOS LICENCIA, SUPLENTE TARDA)
##     rc2[votdat2$yr==2010 & votdat2$mo>4 & votdat2$mo<7, id=="sin08p"] <- 5    ## (GARCIA GRANADOS LICENCIA, SUPLENTE TARDA)
##     rc2[votdat2$yr==2010 & votdat2$mo==2 & votdat2$dy>=23 & votdat2$dy<=25, id=="tam02p"] <- 5  ## (VILLARREAL SALINAS LICENCIA, SUPLENTE TARDA)
##     rc2[votdat2$yr==2010 & votdat2$mo==1 & votdat2$dy>=30, id=="tam05p"] <- 5  ## (TORRE CANTU LICENCIA, SUPLENTE TARDA)
##     rc2[votdat2$yr==2010 & votdat2$mo>=2, id=="tam05p"] <- 5                  ## (TORRE CANTU LICENCIA, SUPLENTE TARDA)
##     rc2[votdat2$yr==2010 & votdat2$mo==3 & votdat2$dy>=1 & votdat2$dy<26, id=="ver11p"] <- 5  ## (GARCIA BRINGAS LICENCIA, SUPLENTE NO JURA)
##     rc2[votdat2$yr==2010 & votdat2$mo==3 & votdat2$dy==23, id=="ver12p"] <- 5  ## (GUDIÑO CORRO LICENCIA, SUPLENTE TARDA)
##     rc2[votdat2$yr==2011 & votdat2$mo==10 & votdat2$dy>=11 & votdat2$dy<13, id=="ver13p"] <- 0  ## (FLORES ESPINOSA LICENCIA, SUPLENTE TARDA)
##     rc2[votdat2$yr==2010 & votdat2$mo==12 & votdat2$dy>=1 & votdat2$dy<7, id=="ver17p"] <- 5  ## (CARRILLO SANCHEZ LICENCIA, SUPLENTE NO JURA)
##     rc2[votdat2$yr==2010 & votdat2$mo==4 & votdat2$dy>=14 & votdat2$dy<20, id=="c3rp32p"] <- 5  ## (SALDAÑA MORAN LICENCIA, SUPLENTE NO JURA)
##     rc2[votdat2$yr>=2011, id=="tam05p"] <- 5 ## (TAM05 VACANT SINCE 1/1/2011)
##     rc2[votdat2$yr==2011 & votdat2$mo==12 & votdat2$dy==15, id=="yuc04p"] <- 0  ## (ZAPATA BELLO LICENCIA, SUPLENTE TARDA)
##     #
##     rc2[votdat2$yr==2012 & votdat2$mo>=2, id=="tam05p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
##     rc2[votdat2$yr==2012 & votdat2$mo>=2, id=="extra1p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
##     #
##     rc2[votdat2$yr==2012 & votdat2$mo>=2, id=="c2rp07p"] <- 0 ## (GARZA FLORES LICENCIA, SU PROPIETARIO NO PARECE VOLVER)
##     rc2[votdat2$yr==2012 & votdat2$mo<4, id=="c3rp09p"] <- 0 ## (JUANITA REGRESA)
##     rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy<=17, id=="c3rp09p"] <- 0 ## (JUANITA REGRESA)
##     rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy<=17, id=="c3rp09p"] <- 0 ## (JUANITA REGRESA)
##     rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=26, id=="mex03p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
##     rc2[votdat2$yr==2012 & votdat2$mo==4  & votdat2$dy>=25, id=="c5rp12p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
##     rc2[votdat2$yr==2012 & votdat2$mo>=2, id=="tam05p"] <- 0 ## (LICENCIA SIN ENTRADA SUPLENTE)
    ##
## compute vote aggregates
votdat2$favor <- apply( rc2, 1, function(x) length(which(x==1)) )
votdat2$contra <- apply( rc2, 1, function(x) length(which(x==2)) )
votdat2$absten <- apply( rc2, 1, function(x) length(which(x==3)) )
votdat2$quorum <- apply( rc2, 1, function(x) length(which(x==4)) )
votdat2$ausen <- apply( rc2, 1, function(x) length(which(x==5)) )
#votdat2[1:5, c("favor","contra")]


## USADOS PARA EXPLORAR SEISES
d<-0
d <- d+1; paste(d, id[d], dipdat2$nom[d]); rc[,d]; votdat2$filename[rc[,d]==6] ## ÚLT LISTA SOLO LOS SEISES
d<-grep(id,pattern="mex35p")
paste(d, id[d], dipdat2$nom[d]); data.frame(x=rc[,d],y=paste(votdat2$yr, votdat2$mo, votdat2$dy, sep=""))

v <- 0
v <- v+1; paste(v, votdat2$filename[v], id[rc2[v,]==6], paste(votdat2$yr[v], votdat2$mo[v], votdat2$dy[v], sep=""), dipdat$part[rc2[v,]==6], dipdat$nom[rc2[v,]==6]); #table(as.numeric(rc2[v,]))
x
as.numeric(rc2[,id=="c5rp12p"]) ## UN DIPUTADO
as.numeric(rc2[v,]) ## EL VOTO

# find roll calls with sixes
tmp <- apply( rc2, 1, function(x) length(which(x==6)) )
tmp <- tmp[tmp>0]

## MERGE OLD AND AND NEW DATA
votdat2$filename <- as.character(votdat2$filename)
rc[(dim(rc)[1] + 1):(dim(rc)[1] + dim(rc2)[1]),] <- rc2
votdat[(dim(votdat)[1] + 1):(dim(votdat)[1] + dim(votdat2)[1]),] <- votdat2
##
## SORT
tmp <- 1:dim(votdat)[1] ## ORDORIG
votdat <- votdat[order(votdat$leg, votdat$yr, votdat$mo, votdat$dy, tmp),]
rc <- rc[order(votdat$leg, votdat$yr, votdat$mo, votdat$dy, tmp),]

rm(encod, filenames, i, I, id, info, j, J, names, names.alt, pty, rc2, tmp, tmp2, votdat2)

save.image( paste(workdir, "votesForWeb", "rc61.RData", sep="/") )
# csv versions
write.table(dipdat, file = paste(workdir, "votesForWeb", "dipdat61.csv", sep="/"), sep=",", row.names = FALSE)
write.table(votdat, file = paste(workdir, "votesForWeb", "votdat61.csv", sep="/"), sep=",", row.names = FALSE)
write.table(rc, file = paste(workdir, "votesForWeb", "rc61.csv", sep="/"), sep=",", row.names = FALSE)









## WORK IN PROGRESS ## PARTY AGGREGATES TO VERIFY THEY MATCH
VOTES tmp <- rep(NA, times=length(filenames)) tots <-
data.frame(aypan=tmp, nypan=tmp, abpan=tmp, qupan=tmp,
aspan=tmp,
                   aypri=tmp, nypri=tmp, abpri=tmp, qupri=tmp, aspri=tmp,
                   ayprd=tmp, nyprd=tmp, abprd=tmp, quprd=tmp, asprd=tmp,
                   aypt=tmp,  nypt=tmp,  abpt=tmp,  qupt=tmp,  aspt=tmp,
                   aypvem=tmp,nypvem=tmp,abpvem=tmp,qupvem=tmp,aspvem=tmp,
                   ayconve=tmp, nyconve=tmp, abconve=tmp, quconve=tmp, asconve=tmp,
                   aypas=tmp, nypas=tmp, abpas=tmp, qupas=tmp, aspas=tmp,
                   aypsn=tmp, nypsn=tmp, abpsn=tmp, qupsn=tmp, aspsn=tmp,
                   ayasd=tmp, nyasd=tmp, abasd=tmp, quasd=tmp, asasd=tmp,
                   aypanal=tmp, nypanal=tmp, abpanal=tmp, qupanal=tmp, aspanal=tmp,
                   aysp=tmp, nysp=tmp, absp=tmp, qusp=tmp, assp=tmp,
                   aytot=tmp, nytot=tmp, abtot=tmp, qutot=tmp, astot=tmp,
                   problem=tmp)
#
allpart <- c("Partido Acción Nacional",
             "Partido Revolucionario Institucional",
             "Partido de la Revolución Democrática")
work <- 1:length(filenames); work <- work[votdat$haveinfo==1]
n <- 13
for (n in work){
fil <- readLines(filenames[n])
ayloc <- grep(fil, pattern="emmAyesStart")
nyloc <- grep(fil, pattern="emmNaysStart")
abloc <- grep(fil, pattern="emmAbstentionsStart")
quloc <- grep(fil, pattern="emmPresentNoVoteStart")
asloc <- grep(fil, pattern="emmAbsencesStart")
enloc <- grep(fil, pattern="emmFileEnds")
ayloc <- c((ayloc+1):(nyloc-1))
nyloc <- c((nyloc+1):(abloc-1))
abloc <- c((abloc+1):(quloc-1))
quloc <- c((quloc+1):(asloc-1))
asloc <- c((asloc+1):(enloc-1))
rm(enloc)
#
fil <- sub(fil, pattern="<FONT COLOR=#990000><center>", replacement="")
##tmp2 <- grep(fil[ayloc], pattern="Diputados .* que.*")                    ##
##tmp <- fil[ayloc]                                                         ##
##tmp <- sub(tmp[tmp2], pattern="Diputados (.*) que.*", replacement="\\1")  ##
##tmp <- sub(tmp, pattern="del Partido", replacement="Partido")             ##
##allpart <- append(allpart, tmp)                                           ##
##} ## UNSTAR SEGMENT & END LOOP HERE TO GET PARTY LABEL COUNT              ##
##table(allpart)                                                            ##
##    ##LAST RESULT allpart
##    ##                     de Convergencia    de Convergencia por la Democracia
##    ##                      Independientes              Partido Acción Nacional
##    ##              Partido Alianza Social                  Partido Alternativa
##    ##Partido de la Revolución Democrática                  Partido del Trabajo
##    ##               Partido Nueva Alianza Partido Revolucionario Institucional
##    ##       Partido Sociedad Nacionalista   Partido Verde Ecologista de México
##    ##                         sin partido
tmp <- fil[ayloc]
subset <- tmp[grep(tmp, pattern=".*Partido Acción Nacional.*")]
tots$aypan[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Partido Revolucionario Institucional.*")]
tots$aypri[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Partido de la Revolución Democrática.*")]
tots$ayprd[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Partido del Trabajo.*")]
tots$aypt[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Partido Nueva Alianza.*")]
tots$aypanal[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Partido Verde.*")]
tots$aypvem[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Convergencia.*")]
tots$ayconve[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Partido Alianza Social.*")]
tots$aypas[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Sociedad Nacionalista.*")]
tots$aypsn[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Alternativa.*")]
tots$ayasd[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*[Iis][ni][dn][e ]p[ea][nr][dt]i[ed][no].*")]
tots$aysp[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
tmp <- fil[nyloc]
subset <- tmp[grep(tmp, pattern=".*Partido Acción Nacional.*")]
tots$nypan[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Partido Revolucionario Institucional.*")]
tots$nypri[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Partido de la Revolución Democrática.*")]
tots$nyprd[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Partido del Trabajo.*")]
tots$nypt[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Partido Nueva Alianza.*")]
tots$nypanal[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Partido Verde.*")]
tots$nypvem[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Convergencia.*")]
tots$nyconve[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Partido Alianza Social.*")]
tots$nypas[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Sociedad Nacionalista.*")]
tots$nypsn[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Alternativa.*")]
tots$nyasd[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*[Iis][ni][dn][e ]p[ea][nr][dt]i[ed][no].*")]
tots$nysp[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
tmp <- fil[abloc]
subset <- tmp[grep(tmp, pattern=".*Partido Acción Nacional.*")]
tots$abpan[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Partido Revolucionario Institucional.*")]
tots$abpri[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Partido de la Revolución Democrática.*")]
tots$abprd[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Partido del Trabajo.*")]
tots$abpt[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Partido Nueva Alianza.*")]
tots$abpanal[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Partido Verde.*")]
tots$abpvem[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Convergencia.*")]
tots$abconve[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Partido Alianza Social.*")]
tots$abpas[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Sociedad Nacionalista.*")]
tots$abpsn[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Alternativa.*")]
tots$abasd[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*[Iis][ni][dn][e ]p[ea][nr][dt]i[ed][no].*")]
tots$absp[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
tmp <- fil[quloc]
subset <- tmp[grep(tmp, pattern=".*Partido Acción Nacional.*")]
tots$qupan[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Partido Revolucionario Institucional.*")]
tots$qupri[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Partido de la Revolución Democrática.*")]
tots$quprd[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Partido del Trabajo.*")]
tots$qupt[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Partido Nueva Alianza.*")]
tots$qupanal[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Partido Verde.*")]
tots$qupvem[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Convergencia.*")]
tots$quconve[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Partido Alianza Social.*")]
tots$qupas[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Sociedad Nacionalista.*")]
tots$qupsn[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Alternativa.*")]
tots$quasd[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*[Iis][ni][dn][e ]p[ea][nr][dt]i[ed][no].*")]
tots$qusp[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
tmp <- fil[asloc]
subset <- tmp[grep(tmp, pattern=".*Partido Acción Nacional.*")]
tots$aspan[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Partido Revolucionario Institucional.*")]
tots$aspri[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Partido de la Revolución Democrática.*")]
tots$asprd[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Partido del Trabajo.*")]
tots$aspt[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Partido Nueva Alianza.*")]
tots$aspanal[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Partido Verde.*")]
tots$aspvem[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Convergencia.*")]
tots$asconve[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Partido Alianza Social.*")]
tots$aspas[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Sociedad Nacionalista.*")]
tots$aspsn[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*Alternativa.*")]
tots$asasd[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
subset <- tmp[grep(tmp, pattern=".*[Iis][ni][dn][e ]p[ea][nr][dt]i[ed][no].*")]
tots$assp[n] <- ifelse(length(subset)>0,
        sub(subset, pattern=".*: ([0-9]*)<.*", replacement="\\1"), NA)
}

save.image(paste(workdir, "/tmp.RData", sep=""))
bkp <- tots

tots <- bkp
for (n in 1:ncol(tots)){
    tots[,n] <- as.numeric(tots[,n])
    }
tmp <- tots
tmp[is.na(tmp)] <- 0
tots$aytot <- tmp$aypan+  tmp$aypri+  tmp$ayprd+  tmp$aypt+
              tmp$aypvem+ tmp$ayconve+ tmp$aypas+  tmp$aypsn+  tmp$ayasd+
              tmp$aypanal+ tmp$aysp
tots$nytot <- tmp$nypan+  tmp$nypri+  tmp$nyprd+  tmp$nypt+
              tmp$nypvem+ tmp$nyconve+ tmp$nypas+  tmp$nypsn+  tmp$nyasd+
              tmp$nypanal+ tmp$nysp
tots$abtot <- tmp$abpan+  tmp$abpri+  tmp$abprd+  tmp$abpt+
              tmp$abpvem+ tmp$abconve+ tmp$abpas+  tmp$abpsn+  tmp$abasd+
              tmp$abpanal+ tmp$absp
tots$qutot <- tmp$qupan+   tmp$qupri+   tmp$quprd+   tmp$qupt+
              tmp$qupvem+  tmp$quconve+ tmp$qupas+   tmp$qupsn+   tmp$quasd+
              tmp$qupanal+ tmp$qusp
tots$astot <- tmp$aspan+ tmp$aspri+ tmp$asprd+ tmp$aspt+
              tmp$aspvem+ tmp$asconve+ tmp$aspas+ tmp$aspsn+ tmp$asasd+
              tmp$aspanal+ tmp$assp
tots$tottot <- tots$aytot + tots$nytot + tots$abtot + tots$qutot + tots$astot
#
tots$problem <- 0
tots$problem[ tots$aytot != votdat$favor ]  <- 1
sum(tots$problem)
tots$problem[ tots$nytot != votdat$contra ] <- 1
sum(tots$problem)
tots$problem[ tots$abtot != votdat$absten ] <- 1
sum(tots$problem)
tots$problem[ tots$qutot != votdat$quorum ] <- 1
sum(tots$problem)
tots$problem[ tots$astot != votdat$ausen ]  <- 1
sum(tots$problem)

tmp <- data.frame(leg=votdat$leg, per=votdat$filename, day=tots$aytot - votdat$favor, ayes=tots$aytot, fav=votdat$favor,
dny=tots$nytot - votdat$contra, nayes=tots$nytot, con=votdat$contra)
tmp[votdat$haveinfo==1 & tots$problem==1,]

BUSCAR PROPIETARIO O SUPLENTE: SI AMBOS EN CERO, DIFFERENT SPELLING

## CONDITIONAL EXAMPLE
#    if (votdat$favor[n] > 0)
#       { direc <- c("http://gaceta.diputados.gob.mx/voto60/ordi22/8/21.lola")
#         url <- url(direc,open="rt")
#         tmp <- append(tmp, readLines(url, warn=FALSE))
#         close(url) } else next
#    tmp <- append(tmp, c("emmAyesEnd"))
