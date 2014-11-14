library (foreign)
library (plyr)

rm(list = ls())
#
workdir <- c("~/Dropbox/data/rollcall/dipMex/")
setwd(workdir)
#
color.list <- c("darkblue", "forestgreen", "gold", "red", "darkolivegreen2", "orange", "cyan","grey")
#
# Read envud data in stata format
envud <- read.dta(file = paste(workdir, "ideol/ENVUD2010.dta", sep = ""))

e <- data.frame(folio = envud$folio) # data frame to receive stimuli for analisis # <-- *** ID ***
#
dim(e)
colnames(envud)[1:10]
#
# select stimuli that I had mostly chosen in older stata do file (others may be of interest, check)
# dummies here are 1-2, with zero for NAs (as for basicspace)
#
e$edon <- as.numeric(envud$estado) # <-- *** ID ***
#
e$d.urb <- 1; e$d.urb[envud$localidad==1] <- 2 # <-- *** ID ***
#
e$d.fem <- 1; e$d.fem[as.numeric(envud$genero)==2] <- 2 # <-- *** ID ***
#
e$n.age <- envud$edad # <-- *** ID ***
#
tmp <- envud$p11201
tmp <- mapvalues(as.numeric(tmp), from = 1:3, to =  c(2,1,0))
e$d.hasPhone <- tmp # <-- *** ID ***
#
tmp <- envud$p11202
tmp <- mapvalues(as.numeric(tmp), from = 1:3, to =  c(2,1,0))
e$d.hasCell <- tmp # <-- *** ID ***
#
tmp <- envud$p11203
tmp <- mapvalues(as.numeric(tmp), from = 1:3, to =  c(2,1,0))
e$d.hasWeb <- tmp # <-- *** ID ***
#
tmp <- envud$p11204
tmp <- mapvalues(as.numeric(tmp), from = 1:3, to =  c(2,1,0))
e$d.hasTweet <- tmp # <-- *** ID ***
#
tmp <- envud$p15
tmp <- mapvalues(as.numeric(tmp), from = 1:6, to =  c(0,5,4,3,2,1))
e$t.class <- tmp # <-- *** ID ***
#
# De los siguientes, ¿cuál le gustaría que fuera el principal objetivo de México como país en los próximos diez años?
tmp1 <- as.numeric(envud$p4)
tmp2 <- as.numeric(envud$p5)
e$t.strongEco <- 1; e$t.strongEco[tmp2==2] <- 2; e$t.strongEco[tmp1==2] <- 3; # 3pt thermo: 1 didn't mention, 2 mentioned 2nd, 3 mentioned 1st  # <-- *** ISSUE ***
e$t.strongLawOrder <- 1; e$t.strongLawOrder[tmp2==3] <- 2; e$t.strongLawOrder[tmp1==3] <- 3; # 3pt thermo: 1 didn't mention, 2 mentioned 2nd, 3 mentioned 1st  # <-- *** ISSUE ***
e$t.strongSocSec <- 1; e$t.strongSocSec[tmp2==4] <- 2; e$t.strongSocSec[tmp1==4] <- 3; # 3pt thermo: 1 didn't mention, 2 mentioned 2nd, 3 mentioned 1st  # <-- *** ISSUE ***
e$t.strongDemoc <- 1; e$t.strongDemoc[tmp2==5] <- 2; e$t.strongDemoc[tmp1==5] <- 3; # 3pt thermo: 1 didn't mention, 2 mentioned 2nd, 3 mentioned 1st  # <-- *** ISSUE ***
#
# d.revruin "Rev. perjudico algo/mucho"
tmp <- envud$p10
tmp <- mapvalues(as.numeric(tmp), from = 1:6, to =  c(0,2,2,1,1,1))
e$d.revruin <- tmp # <-- *** ISSUE ***
#
# ¿Cree usted que, hoy en día, una revolución ayudaría o perjudicaría al le interesan a los ciudadanos en nuestro país. Quisiera hacerle unas país? (0=NS/NC: 5=Ni una ni otra)
tmp <- envud$p11
tmp <- mapvalues(as.numeric(tmp), from = 1:6, to =  c(0,5,4,2,1,3))
e$t.newRevolHelp <- tmp # <-- *** BELIEF ***
#
# ¿en su estado (DF) cuántas oportunidades para salir adelante hay?
e$t.landOpport <- envud$p12011 # <-- *** BELIEF ***
#
#  d.hardwork "para mejorar preparacion/trabajar duro" was mentioned
tmp1 <- as.numeric(envud$p2001) - 1; tmp2 <- as.numeric(envud$p2002) - 1; tmp3 <- as.numeric(envud$p2003) - 1
tmp <- rep(1, length(tmp1)); tmp[tmp1==1 | tmp1==2 | tmp2==1 | tmp2==2 | tmp3==1 | tmp3==2] <- 2; tmp[tmp1==0 & tmp2==0 & tmp3==0] <- 0
e$d.hardwork <- tmp # <-- *** BELIEF ***
#
# d.govhelp "para mejorar palancas/ayuda gob" was mentioned
tmp1 <- as.numeric(envud$p2001) - 1; tmp2 <- as.numeric(envud$p2002) - 1; tmp3 <- as.numeric(envud$p2003) - 1
tmp <- rep(1, length(tmp1)); tmp[tmp1==3 | tmp1==8 | tmp2==3 | tmp2==8 | tmp3==3 | tmp3==8] <- 2; tmp[tmp1==0 & tmp2==0 & tmp3==0] <- 0
e$d.govhelp <- tmp # <-- *** BELIEF ***
#
#  d.badgov "3 aspectos que más impiden mejorar, inseguridad/malGobierno" mentioned
tmp1 <- as.numeric(envud$p2101) - 1; tmp2 <- as.numeric(envud$p2102) - 1; tmp3 <- as.numeric(envud$p2103) - 1
tmp <- rep(1, length(tmp1)); tmp[tmp1==8 | tmp1==9 | tmp2==8 | tmp2==9 | tmp3==8 | tmp3==9] <- 2; tmp[tmp1==0 & tmp2==0 & tmp3==0] <- 0
e$d.badgov <- tmp # <-- *** BELIEF ***
#
# Le voy a leer algunos cambios en nuestra forma de vida que podrían darse en un futuro cercano. Dígame para cada uno, si sucediera, usted cree que sería bueno, sería malo o no le importaría
tmp <- envud$p2701
tmp <- mapvalues(as.numeric(tmp), from = 1:4, to =  c(0,3,1,2))
e$t.techGood <- tmp # más tecnología # <-- *** ISSUE ***
tmp <- envud$p2702
tmp <- mapvalues(as.numeric(tmp), from = 1:4, to =  c(0,3,1,2))
e$t.respectGood <- tmp # más respeto por la autoridad # <-- *** ISSUE ***
tmp <- envud$p2703
tmp <- mapvalues(as.numeric(tmp), from = 1:4, to =  c(0,3,1,2))
e$t.diversityGood <- tmp # más diversidad # <-- *** ISSUE ***
tmp <- envud$p2704
tmp <- mapvalues(as.numeric(tmp), from = 1:4, to =  c(0,3,1,2))
e$t.moreTradeGood <- tmp # más comercio con otros países # <-- *** ISSUE ***
#
tmp <- envud$p29014
tmp <- mapvalues(as.numeric(tmp), from = 1:5, to =  c(0,4:1))
e$t.ifeTrust <- tmp # confianza ife # <-- *** BELIEF ***
#
tmp <- envud$p29019
tmp <- mapvalues(as.numeric(tmp), from = 1:5, to =  c(0,4:1))
e$t.smallBusinessTrust <- tmp # confianza pequeñas empresas # <-- *** BELIEF ***
#
tmp <- envud$p29020
tmp <- mapvalues(as.numeric(tmp), from = 1:5, to =  c(0,4:1))
e$t.neighborTrust <- tmp # confianza vecinos # <-- *** BELIEF ***
#
# d.naftaok "Nafta has been good/very"
tmp <- envud$p36
tmp <- mapvalues(as.numeric(tmp), from = 1:6, to =  c(0,5,4,3,2,1))
e$t.naftaok <- tmp # <-- *** ISSUE ***
#
# t.tradeGood 3-pt "World trade good"
tmp <- envud$p35
tmp <- mapvalues(as.numeric(tmp), from = 1:4, to =  c(0,3,1,2))
e$t.tradeGood <- tmp # <-- *** ISSUE ***
#
# t.sovNafta 3-pt "Sovereignty and nafta"
tmp <- envud$p37
tmp <- mapvalues(as.numeric(tmp), from = 1:4, to =  c(0,3,1,2))
e$t.sovNafta <- tmp # <-- *** BELIEF ***
#
# "how much interest in..."
e$intPol <- envud$p4401 # <-- *** ID ***
e$knowRights <- envud$p4402 # <-- *** ID ***
e$turnout <- envud$p4403 # <-- *** ID ***
e$news <- envud$p4404 # <-- *** ID ***
e$talkPol <- envud$p4405 # <-- *** ID ***
#
# d.democpref "democracy always preferable"
tmp <- envud$p45
tmp <- mapvalues(as.numeric(tmp), from = 1:4, to =  c(0,2,1,1))
e$d.democpref <- tmp # <-- *** BELIEF ***
#
# d.authok "authoritarian sometimes pref"
tmp <- envud$p45
tmp <- mapvalues(as.numeric(tmp), from = 1:4, to =  c(0,1,2,1))
e$d.authok <- tmp # <-- *** BELIEF ***
#
# t.mxDemoc "how democratic is Mexico"
e$t.mxDemoc <- envud$p4601 # <-- *** BELIEF ***
#
# t.staDemoc "how democratic is your state"
e$t.staDemoc <- envud$p4602 # <-- *** BELIEF ***
#
# Satisfaction with country's democracy
e$satisfiedDem <- envud$p4801 # <-- *** ISSUE ***
#
# d.fchApprov "approve or not Calderón"
tmp <- envud$p5401
tmp <- mapvalues(as.numeric(tmp), from = 1:3, to =  c(0,2,1))
e$d.fchApprov <- tmp # <-- *** ISSUE ***
#
# t.media "media inform properly"
tmp <- envud$p55
tmp <- mapvalues(as.numeric(tmp), from = 1:6, to =  c(0,5:1))
e$t.media <- tmp # <-- *** BELIEF ***
#
# Prioridades
tmp1 <- as.numeric(envud$p58)
tmp2 <- as.numeric(envud$p58b)
e$t.order     <- 1; e$t.order[tmp2==2] <- 2; e$t.order[tmp1==2] <- 3; # 3pt thermo: 1 didn't mention, 2 mentioned 2nd, 3 mentioned 1st  # <-- *** ISSUE ***
e$t.partic    <- 1; e$t.partic[tmp2==3] <- 2; e$t.partic[tmp1==3] <- 3; # 3pt thermo: 1 didn't mention, 2 mentioned 2nd, 3 mentioned 1st  # <-- *** ISSUE ***
e$t.inflation <- 1; e$t.inflation[tmp2==4] <- 2; e$t.inflation[tmp1==4] <- 3; # 3pt thermo: 1 didn't mention, 2 mentioned 2nd, 3 mentioned 1st  # <-- *** ISSUE ***
e$t.freedom   <- 1; e$t.freedom[tmp2==5] <- 2; e$t.freedom[tmp1==5] <- 3; # 3pt thermo: 1 didn't mention, 2 mentioned 2nd, 3 mentioned 1st  # <-- *** ISSUE ***
#
# t.environ "environment important"
e$t.environ <- envud$p59 # <-- *** ISSUE ***
#
# d.univfee "public university should not be free"
e$d.univfee <- as.numeric(envud$p65) - 1 # <-- *** ISSUE ***
#
# d.unionsharm "unions tend to harm"
e$d.unionsHarm <- as.numeric(envud$p68) - 1 # <-- *** ISSUE ***
#
# left/right self-placement in politics
e$t.lrSelf <- envud$p70 # <-- *** ISSUE ***
#
# t.equality 10-pt thermometer, 1 = more income differences as incentive for effort -- 10 = more income equality
tmp <- envud$p7101
tmp <- mapvalues(as.numeric(tmp), from = 0:10, to =  c(0,10:1))
e$t.equality <- tmp # <-- *** ISSUE ***
#
# t.privBus 10-pt thermometer, 1 = government should own firms -- 10 = private business
tmp <- envud$p7102
tmp <- mapvalues(as.numeric(tmp), from = 0:10, to =  c(0,10:1))
e$t.privBus <- tmp # <-- *** ISSUE ***
#
# t.selfRely 10-pt thermometer, 1 = government responsible for sustento -- 10 = self-reliance
e$t.selfRely <- envud$p7103 # <-- *** ISSUE ***
#
# t.competGood 10-pt thermo, 1 = competition is bad -- 10 = is good
tmp <- envud$p7104
tmp <- mapvalues(as.numeric(tmp), from = 0:10, to =  c(0,10:1))
e$t.competGood <- tmp # <-- *** ISSUE ***
#
# t.lessTax 10-pt thermo, 1 = more public services -- 10 = less taxes
e$t.lessTax <- envud$p7105 # <-- *** ISSUE ***
#
# t.invisibleHand 10-pt thermo, 1 = more dirigisme -- 10 = more Adam Smith
e$t.invisibleHand <- envud$p7106 # <-- *** ISSUE ***
#
# d.moreFdi ¿inversión extranjera aumentar?
tmp <- envud$p72
tmp <- mapvalues(as.numeric(tmp), from = 1:3, to =  c(0,2,1))
e$d.moreFdi <- tmp # <-- *** ISSUE ***
#
# d.pemexPriv ¿Está usted a favor o en contra de que se permita la inversión de capital privado en la industria petrolera del país?
tmp <- envud$p73
tmp <- mapvalues(as.numeric(tmp), from = 1:3, to =  c(0,2,1))
e$d.pemexPriv <- tmp # <-- *** ISSUE ***
#
# d.cfePriv ¿Está usted a favor o en contra de que se permita la inversión de capital privado en la industria eléctrica del país?
tmp <- envud$p74
tmp <- mapvalues(as.numeric(tmp), from = 1:3, to =  c(0,2,1))
e$d.cfePriv <- tmp # <-- *** ISSUE ***
#
# t.govHindersDev 10-pt thermo 1 = gov helps towards development -- 10 = gov hinders
tmp <- envud$p7501
tmp <- mapvalues(as.numeric(tmp), from = 0:10, to =  c(0,10:1))
e$t.govHindersDev <- tmp # <-- *** ISSUE ***
#
# t.busHelpsDev 10-pt thermo 1 = business hinders development -- 10 = business helps
e$t.busHelpsDev <- envud$p7502 # <-- *** ISSUE ***
#
# En estos momentos, ¿cuál debería ser la tarea más importante del gobierno?
tmp <- as.numeric(envud$p76)
e$d.crime <- 1; e$d.crime[tmp==2] <- 2 # <-- *** ISSUE ***
e$d.health <- 1; e$d.health[tmp==3] <- 2 # <-- *** ISSUE ***
e$d.education <- 1; e$d.education[tmp==4] <- 2 # <-- *** ISSUE ***
e$d.poverty <-1; e$d.poverty[tmp==5] <- 2 # <-- *** ISSUE ***
e$d.employ <- 1; e$d.employ[tmp==6] <- 2 # <-- *** ISSUE ***
#
# 10-pt thermo issues: 1 = siempre se justifica -- 10 = nunca se justifica
tmp <- envud$p81001
tmp <- mapvalues(as.numeric(tmp), from = 0:10, to =  c(0,10:1))
e$t.antiTaxCheat <- tmp # <-- *** ISSUE ***
tmp <- envud$p81002
tmp <- mapvalues(as.numeric(tmp), from = 0:10, to =  c(0,10:1))
e$t.antiBribe <- tmp # <-- *** ISSUE ***
tmp <- envud$p81003
tmp <- mapvalues(as.numeric(tmp), from = 0:10, to =  c(0,10:1))
e$t.antiGay <- tmp # <-- *** ISSUE ***
tmp <- envud$p81004
tmp <- mapvalues(as.numeric(tmp), from = 0:10, to =  c(0,10:1))
e$t.antiAbortion <- tmp # <-- *** ISSUE ***
tmp <- envud$p81005
tmp <- mapvalues(as.numeric(tmp), from = 0:10, to =  c(0,10:1))
e$t.antiDivorce <- tmp # <-- *** ISSUE ***
tmp <- envud$p81006
tmp <- mapvalues(as.numeric(tmp), from = 0:10, to =  c(0,10:1))
e$t.AntiEutan <- tmp # <-- *** ISSUE ***
tmp <- envud$p81007
tmp <- mapvalues(as.numeric(tmp), from = 0:10, to =  c(0,10:1))
e$t.AntiHitWife <- tmp # <-- *** ISSUE ***
tmp <- envud$p81008
tmp <- mapvalues(as.numeric(tmp), from = 0:10, to =  c(0,10:1))
e$t.AntiKill <- tmp # <-- *** ISSUE ***
tmp <- envud$p81009
tmp <- mapvalues(as.numeric(tmp), from = 0:10, to =  c(0,10:1))
e$t.antiSpouseCheat <- tmp # <-- *** ISSUE ***
tmp <- envud$p81010
tmp <- mapvalues(as.numeric(tmp), from = 0:10, to =  c(0,10:1))
e$t.antiFakeIll <- tmp # <-- *** ISSUE ***
#
# d.proLife En el tema del aborto ha habido dos puntos de vista: la postura que defiende la vida sobre todas las cosas, y la postura que antepone el derecho de la mujer a decidir
tmp <- envud$p82
tmp <- mapvalues(as.numeric(tmp), from = 1:3, to =  c(0,2,1))
e$d.proLife <- tmp # <-- *** ISSUE ***
#
# d.noGayMarry ¿Usted está de acuerdo o en desacuerdo con el matrimonio o unión legal entre personas del mismo sexo?
tmp <- envud$p83
tmp <- mapvalues(as.numeric(tmp), from = 1:3, to =  c(0,1,2))
e$d.noGayMarry <- tmp # <-- *** ISSUE ***
#
# t.progConser En estos temas sociales suele hablarse de posturas progresistas y conservadoras. En una escala del 1 al 10, donde 1 es ser “progresista” y 10 “conservador”, ¿en dónde se ubicaría usted?
e$t.progConser <- envud$p84 # <-- *** ISSUE ***
#
# d.tieneIfe
tmp <- envud$p85
tmp <- mapvalues(as.numeric(tmp), from = 1:4, to =  c(0,2,2,1))
e$d.tieneIfe <- tmp # <-- *** ID ***
#
# d.Expected vote in 2012
tmp <- envud$p86                                               # 1 2 3 4 5 6 7 8 9 0
e$d.forpan    <- mapvalues(as.numeric(tmp), from = 1:10, to =  c(1,2,1,1,1,1,1,1,1,1)) # <-- *** ID ***
e$d.forpri    <- mapvalues(as.numeric(tmp), from = 1:10, to =  c(1,1,2,1,1,1,1,1,1,1)) # <-- *** ID ***
e$d.forprd    <- mapvalues(as.numeric(tmp), from = 1:10, to =  c(1,1,1,2,1,1,1,1,1,1)) # <-- *** ID ***
e$d.foroth    <- mapvalues(as.numeric(tmp), from = 1:10, to =  c(1,1,1,1,2,2,2,2,1,1)) # <-- *** ID ***
e$d.undecided <- mapvalues(as.numeric(tmp), from = 1:10, to =  c(2,1,1,1,1,1,1,1,1,1)) # <-- *** ID ***
e$d.forblank  <- mapvalues(as.numeric(tmp), from = 1:10, to =  c(1,1,1,1,1,1,1,1,2,1)) # <-- *** ID ***
e$d.novote    <- mapvalues(as.numeric(tmp), from = 1:10, to =  c(1,1,1,1,1,1,1,1,1,2)) # <-- *** ID ***
#
# d.party id
tmp <- envud$p87                                          # 1 2 3 4 5 6 7 8 9
e$d.panid <- mapvalues(as.numeric(tmp), from = 1:9, to =  c(1,1,1,2,2,1,1,1,1)) # <-- *** ID ***
e$d.priid <- mapvalues(as.numeric(tmp), from = 1:9, to =  c(1,2,2,1,1,1,1,1,1)) # <-- *** ID ***
e$d.prdid <- mapvalues(as.numeric(tmp), from = 1:9, to =  c(1,1,1,1,1,2,2,1,1)) # <-- *** ID ***
e$d.othid <- mapvalues(as.numeric(tmp), from = 1:9, to =  c(1,1,1,1,1,1,1,2,1)) # <-- *** ID ***
e$d.indep <- mapvalues(as.numeric(tmp), from = 1:9, to =  c(1,1,1,1,1,1,1,1,2)) # <-- *** ID ***
#
# d.strongPartisan
e$d.strongPartisan <- mapvalues(as.numeric(tmp), from = 1:9, to =  c(1,2,1,2,1,2,1,2,1)) # <-- *** ID ***
#
# t.secure Qué tan seguro considera que es vivir en su estado/ [en el DF]? Responda del 1 al 10, donde 1 significa que “no es nada seguro” y 10 que “es muy seguro
# t.violence ¿Cómo calificaría el nivel de violencia que hay en su estado (DF) en estos momentos? Responda del 1 al 10, donde 1 significa que “no hay nada de violencia” y 10 que “hay mucha violencia”
e$t.secure   <- envud$p90 # <-- *** BELIEF ***
e$t.violence <- envud$p91 # <-- *** BELIEF ***
#
# t.narcoSuccess 10-pt thermo, ¿Cuánto éxito está teniendo el Gobierno en el combate contra el narcotráfico?
e$t.narcoSuccess <- envud$p92 # <-- *** ISSUE ***
#
# t.usa 10-pt thermo opinion U.S.
e$t.usa <- envud$p95 # <-- *** BELIEF ***
#
# t.godsImportance 10-pt thermo, ¿Qué tan importante es Dios en su vida?
e$t.godsImportance <- envud$p100 # <-- *** ID ***
#
# t.virgenImportance 10-pt thermo, ¿Qué tan importante es Dios en su vida?
e$t.virgenImportance <- envud$p1010 # <-- *** ID ***
#
# t.modern En una escala del 1 al 10, donde 1 significa un país “muy tradicional” y 10 un país “muy moderno”, ¿cómo describiría a México?
e$t.modern <- envud$p1020 # <-- *** BELIEF ***
#
# t.scarcity En una escala del 1 al 10, donde 1 significa un país donde predomina la “escasez” y 10 un país donde predomina el “bienestar”, ¿cómo describiría a México?
tmp <- envud$p103
tmp <- mapvalues(as.numeric(tmp), from = 0:10, to =  c(0,10:1))
e$t.scarcity <- tmp # <-- *** BELIEF ***
#
# education thermometer
e$t.educ <- envud$p104 # <-- *** ID ***
#
# religion dummies
tmp <- envud$p110
e$d.cathol <- mapvalues(as.numeric(tmp), from = 1:5, to =  c(0,2,1,1,1)) # <-- *** ID ***
e$d.protes <- mapvalues(as.numeric(tmp), from = 1:5, to =  c(0,1,2,1,1)) # <-- *** ID ***
e$d.other  <- mapvalues(as.numeric(tmp), from = 1:5, to =  c(0,1,1,2,1)) # <-- *** ID ***
e$d.norel  <- mapvalues(as.numeric(tmp), from = 1:5, to =  c(0,1,1,1,2)) # <-- *** ID ***
#
# t.church 5-pt thermo on frequency of church attendance
tmp <- envud$p111
e$t.church <- mapvalues(as.numeric(tmp), from = 1:6, to =  c(0,5:1)) # <-- *** ID ***
#
# add rownames
rownames(e) <- paste("r", 1:nrow(e), sep = "")
#
# clean
rm(tmp,tmp1,tmp2,tmp3)

## tmp <- envud$p86 # debug: select a variable
## table( tmp ) # debug
## table( as.numeric(tmp) ) # debug
## table( is.na(tmp) ) # debug
## str(tmp) # debug

# keep scalable info only, id with respondent traits separate
select <- which( colnames(e) %in% c("folio","edon","d.urb","d.fem","n.age","d.hasPhone","d.hasCell","d.hasWeb","d.hasTweet","t.class","intPol",
                                    "knowRights","turnout","news","talkPol","d.tieneIfe","d.forpan","d.forpri","d.forprd","d.foroth",
                                    "d.undecided","d.forblank","d.novote","d.panid","d.priid","d.prdid","d.othid","d.indep","d.strongPartisan",
                                    "t.godsImportance","t.virgenImportance","t.educ","d.cathol","d.protes","d.other","d.norel","t.church") )
e.id <- e[,select]
e <- e[,-select]
rm(select)
#
# pty with my codes (small coded as independent for now)
e.id$pty <- 0
e.id$pty[e.id$d.panid==2] <- 1 #pan
e.id$pty[e.id$d.priid==2] <- 2 #pri
e.id$pty[e.id$d.prdid==2] <- 3 #prd
e.id$pty[e.id$d.othid==2 | e.id$d.indep==2] <- 8 #indep
#
## # drop stimulus that remains a factor (yet may be close to something in elite survey)
## select <- which( colnames(e) %in% c("f.govPriority", "f.govPriorityOth") )
## e <- e[, -select]
## head(e)

# indices for wide bridge
select <- which( colnames(e) %in% c("d.cfePriv",       # 1
                                    "d.pemexPriv",     # 2
                                    "d.democpref",     # 3
                                    "d.authok",        # 3
                                    "t.mxDemoc",       # 3
                                    "d.fchApprov",     # 4
                                    "t.moreTradeGood", # 5
                                    "t.naftaok",       # 5
                                    "t.tradeGood",     # 5
                                    "t.antiGay",       # 6
                                    "d.noGayMarry",    # 6
                                    "t.antiAbortion",  # 7
                                    "d.proLife",       # 7
                                    "t.lrSelf",        # 8
                                    "t.order",         # 9
                                    "t.partic",        # 9
                                    "t.inflation",     # 9
                                    "t.freedom",       # 9
                                    "t.ifeTrust",      # 10
                                    "t.privBus",       # 11
                                    "t.selfRely",      # 11
                                    "t.competGood",    # 11
                                    "t.lessTax",       # 11
                                    "t.invisibleHand", # 11
                                    "t.progConser")    # 12
                    )
#
e.w.br <- e[,select]
rm(select)

# indices for narrow bridge
select <- which( colnames(e) %in% c("d.cfePriv",       # 1
                                    "d.pemexPriv",     # 2
#                                    "d.democpref",     # 3
#                                    "d.authok",        # 3
                                    "t.mxDemoc",       # 3
                                    "d.fchApprov",     # 4
                                    "t.moreTradeGood", # 5
#                                    "t.naftaok",       # 5
#                                    "t.tradeGood",     # 5
                                    "t.antiGay",       # 6
#                                    "d.noGayMarry",    # 6
                                    "t.antiAbortion",  # 7
#                                    "d.proLife",       # 7
                                    "t.lrSelf",        # 8
                                    "t.order",         # 9
#                                    "t.partic",        # 9
#                                    "t.inflation",     # 9
                                    "t.freedom",       # 9
                                    "t.ifeTrust",      # 10
                                    "t.privBus",       # 11
#                                    "t.selfRely",      # 11
#                                    "t.competGood",    # 11
#                                    "t.lessTax",       # 11
                                    "t.invisibleHand", # 11
                                    "t.progConser")    # 12
                    )
#
e.n.br <- e[,select]
rm(select)


## # all colnames(e) kept from envud
## "d.revruin", # <-- *** ISSUE ***
## "t.strongEco", # <-- *** ISSUE ***
## "t.strongLawOrder", # <-- *** ISSUE ***
## "t.strongSocSec", <- 1 # <-- *** ISSUE ***
## "t.strongDemoc", <- 1 # <-- *** ISSUE ***
## "t.newRevolHelp", # <-- *** BELIEF ***
## "t.landOpport", # <-- *** BELIEF ***
## "d.hardwork", # <-- *** BELIEF ***
## "d.govhelp", # <-- *** BELIEF ***
## "d.badgov", # <-- *** BELIEF ***
## "t.techGood", # <-- *** ISSUE ***
## "t.respectGood", # <-- *** ISSUE ***
## "t.diversityGood", # <-- *** ISSUE ***
## "t.moreTradeGood", # <-- *** ISSUE ***  <<<BRIDGE>>>
## "t.ifeTrust", # <-- *** BELIEF ***        <<<BRIDGE>>>
## "t.smallBusinessTrust", # <-- *** BELIEF ***
## "t.neighborTrust", # <-- *** BELIEF ***
## "t.naftaok", # <-- *** ISSUE ***        <<<BRIDGE>>>
## "t.tradeGood", # <-- *** ISSUE ***      <<<BRIDGE>>>
## "t.sovNafta", # <-- *** BELIEF ***
## "d.democpref", # <-- *** BELIEF ***     <<<BRIDGE>>>
## "d.authok", # <-- *** BELIEF ***        <<<BRIDGE>>>
## "t.mxDemoc", # <-- *** BELIEF ***       <<<BRIDGE>>>
## "t.staDemoc", # <-- *** BELIEF ***
## "satisfiedDem", # <-- *** ISSUE ***
## "d.fchApprov", # <-- *** ISSUE ***      <<<BRIDGE>>>
## "t.media", # <-- *** BELIEF ***         <<<BRIDGE>>>
## "t.order",      # <-- *** ISSUE ***        <<<BRIDGE>>>
## "t.partic", # <-- *** ISSUE ***        <<<BRIDGE>>>
## "t.inflation",  # <-- *** ISSUE ***        <<<BRIDGE>>>
## "t.freedom",    # <-- *** ISSUE ***        <<<BRIDGE>>>
## "t.environ", # <-- *** ISSUE ***
## "d.univfee", # <-- *** ISSUE ***
## "d.unionsHarm", # <-- *** ISSUE ***
## "t.lrSelf", # <-- *** ISSUE ***         <<<BRIDGE>>>
## "t.equality", # <-- *** ISSUE ***
## "t.privBus", # <-- *** ISSUE ***        <<<BRIDGE>>>
## "t.selfRely", # <-- *** ISSUE ***        <<<BRIDGE>>>
## "t.competGood", # <-- *** ISSUE ***        <<<BRIDGE>>>
## "t.lessTax", # <-- *** ISSUE ***        <<<BRIDGE>>>
## "t.invisibleHand", # <-- *** ISSUE ***        <<<BRIDGE>>>
## "d.moreFdi", # <-- *** ISSUE ***
## "d.pemexPriv", # <-- *** ISSUE ***      <<<BRIDGE>>>
## "d.cfePriv", # <-- *** ISSUE ***        <<<BRIDGE>>>
## "t.govHindersDev", # <-- *** ISSUE ***
## "t.busHelpsDev", # <-- *** ISSUE ***
## "d.crime", # <-- *** ISSUE ***
## "d.health", # <-- *** ISSUE ***
## "d.education", # <-- *** ISSUE ***
## "d.poverty", # <-- *** ISSUE ***
## "d.employ", # <-- *** ISSUE ***
## "t.antiTaxCheat", # <-- *** ISSUE ***
## "t.antiBribe", # <-- *** ISSUE ***
## "t.antiGay", # <-- *** ISSUE ***        <<<BRIDGE>>>
## "t.antiAbortion", # <-- *** ISSUE ***   <<<BRIDGE>>>
## "t.antiDivorce", # <-- *** ISSUE ***
## "t.AntiEutan", # <-- *** ISSUE ***
## "t.AntiHitWife", # <-- *** ISSUE ***
## "t.AntiKill", # <-- *** ISSUE ***
## "t.antiSpouseCheat", # <-- *** ISSUE ***
## "t.antiFakeIll", # <-- *** ISSUE ***
## "d.proLife", # <-- *** ISSUE ***         <<<BRIDGE>>>
## "d.noGayMarry", # <-- *** ISSUE ***      <<<BRIDGE>>>
## "t.progConser", # <-- *** ISSUE ***      <<<BRIDGE>>>
## "t.secure",   # <-- *** BELIEF ***
## "t.violence", # <-- *** BELIEF ***
## "t.narcoSuccess", # <-- *** ISSUE ***
## "t.usa", # <-- *** BELIEF ***
## "t.modern", # <-- *** BELIEF ***
## "t.scarcity", # <-- *** BELIEF ***




#########################################
##  prepare Reforma elite survey data  ##
#########################################

el09 <- read.spss(paste(workdir, "ideol/elite2009/Diputados09.sav", sep=""), to.data.frame=TRUE)
colnames(el09)[which(colnames(el09)=="p335d")] <- "p35d" # error in database
d <- data.frame(folio = el09$folio) # data frame to receive transformed variables
#
###############################################################################################################
## THIS VERSION TURNS CATEGORICAL AND ORDINAL VARIABLES INTO DUMMIES (some thermometers reconstructed below) ##
## Missing values are NAs here                                                                               ##
###############################################################################################################
#
# 1. ¿Cuál de las siguientes reformas cree que debe tener la más alta prioridad para la LXI Legislatura? (Cuáles mencionó, inconsistencia base y cuestionario)
d$prioEner <- 0; d$prioEner[as.numeric(el09$p1a)==1] <- 1
d$prioLab <- 0; d$prioLab[as.numeric(el09$p1b)==1] <- 1
d$prioEdo <- 0; d$prioEdo[as.numeric(el09$p1c)==1 | as.numeric(el09$p1f)==1] <- 1
d$prioCampo <- 0; d$prioCampo[as.numeric(el09$p1d)==1] <- 1
d$prioHda <- 0; d$prioHda[as.numeric(el09$p1e)==1] <- 1
d$prioSalud <- 0; d$prioSalud[as.numeric(el09$p1g)==1] <- 1
d$prioEduc <- 0; d$prioEduc[as.numeric(el09$p1h)==1] <- 1
d$prioJust <- 0; d$prioJust[as.numeric(el09$p1i)==1] <- 1
#
# 2. ¿Cuál cree que debe ser el principal objetivo de una reforma del Estado?
tmp <- as.numeric( el09$p2 )
d$orden <- 0; d$orden[tmp==1] <- 1
d$derechos <- 0; d$derechos[tmp==2] <- 1
#
# 3. ¿Cuál cree que debe ser el principal objetivo de una reforma fiscal?
tmp <- as.numeric( el09$p3 )
d$recaudar <- 0; d$recaudar[tmp==1 | tmp==5] <- 1
d$incentivar <- 0; d$incentivar[tmp==2 | tmp==5] <- 1
#
# 4. ¿Cuál cree que debe ser el principal objetivo de una reforma electoral?
tmp <- as.numeric( el09$p4 )
d$costo <- 0; d$costo[tmp==1 | tmp==5] <- 1
d$confianza <- 0; d$confianza[tmp==2 | tmp==5] <- 1
#
# II. SECTOR ENERGÉTICO
# 5. ¿Considera usted que, para mejorar el servicio eléctrico en los próximos años, es suficiente el gasto del gobierno, o cree que se requieren inversiones privadas, además de las del gobierno? 
tmp <- as.numeric( el09$p5 )
d$cfePriv <- 0; d$cfePriv[tmp==2] <- 1; d$cfePriv[tmp==3] <- NA
#
# 6. ¿Considera usted que, para mejorar la producción petrolera en los próximos años, es suficiente el gasto del gobierno, o cree que se requieren inversiones privadas, además de las del gobierno? 
tmp <- as.numeric( el09$p6 )
d$pemexPriv <- 0; d$pemexPriv[tmp==2] <- 1; d$pemexPriv[tmp==3] <- NA
#
# 7. ¿Está a favor o en contra de que Pemex se asocie con empresas privadas para la exploración de aguas profundas del Golfo de México?
tmp <- as.numeric( el09$p7 )
d$golfoPriv <- 0; d$golfoPriv[tmp==2] <- 1; d$golfoPriv[tmp==3] <- NA
#
# 8. ¿Está a favor o en contra de que Pemex se asocie con empresas estatales de otros países para la exploración de aguas profundas del Golfo de México?
tmp <- as.numeric( el09$p8 )
d$golfoPara <- 0; d$golfoPara[tmp==2] <- 1; d$golfoPara[tmp==3] <- NA
#
# 9. ¿Cree usted que la reforma en el sector petrolero que aprobó la anterior legislatura es suficiente para mejorar el desempeño de Pemex o se requieren de más cambios?
tmp <- as.numeric( el09$p9 )
d$sqPetrOk <- 0; d$sqPetrOk[tmp==2] <- 1; d$sqPetrOk[tmp==3] <- NA
#
# III. PRESUPUESTO Y TEMAS FISCALES 
# 10. ¿Cuál de las siguientes opciones de gasto público prefiere usted?
tmp <- as.numeric( el09$p10 )
d$masAedos <- 0; d$masAedos[tmp==2] <- 1; d$masAedos[tmp==3] <- NA
#
# 11. Para fortalecer el federalismo en México ¿cuál de las siguientes opciones prefiere?
tmp <- as.numeric( el09$p11 )
d$edosRecauden <- 0; d$edosRecauden[tmp==2] <- 1; d$edosRecauden[tmp==3] <- NA
#
## NO HE ENCONTRADO FORMA DE DICOTOMIZAR ESTA VARIABLE, NECESITO MÉTODO PARA IRT CON VALORES ENTRE 0 Y 1 MCGANN?
## # 12. ¿Qué porcentaje del presupuesto de egresos asignaría usted a las siguientes áreas? (recoded to always add to 1)
## tmp <- el09[,grep(pattern = "p12", x = colnames(el09))]
## tmp[is.na(tmp)] <- 0
## tmp <- round( tmp/apply(tmp, 1, sum), 2)
#
# 13. Considerando el actual presupuesto, ¿en qué porcentaje aumentaría o reduciría el gasto público total?
tmp <- as.numeric( el09$p13 )
d$masGasto <- 0; d$masGasto[tmp==1] <- 1; d$masGasto[tmp==4] <- NA
d$menosGasto <- 0; d$menosGasto[tmp==2] <- 1; d$menosGasto[tmp==4] <- NA
#d$mismoGasto <- 0; d$mismoGasto[tmp==3] <- 1; d$mismoGasto[tmp==4] <- NA
#
# 14. ¿Está de acuerdo o en desacuerdo con uniformar la tasa del IVA a todos los productos?
tmp <- as.numeric( el09$p14 )
d$ivaUnico <- 0; d$ivaUnico[tmp==1] <- 1; d$ivaUnico[tmp==3] <- NA
#
# 15. En su opinión, la actual tasa cero en alimentos y medicinas, ¿debe permanecer así o debe modificarse?
tmp <- as.numeric( el09$p15 )
d$ivaAlim <- 0; d$ivaAlim[tmp==2] <- 1; d$ivaAlim[tmp==3] <- NA
#
# 16. ¿Usted está a favor o en contra de la propuesta del Gobierno federal de aplicar un impuesto del 2 por ciento al consumo para que se destine al combate a la pobreza?
tmp <- as.numeric( el09$p16 )
d$ivaPobres <- 0; d$ivaPobres[tmp==2] <- 1; d$ivaPobres[tmp==3] <- NA
#
# IV. POLÍTICA Y ESTADO 
#
# 17. ¿Cuál de las siguientes posturas se acerca más a su manera de ver la democracia hoy en día? (ordinal turned set of dummies)
tmp <- as.numeric( el09$p17 )
## d$consolidada <- 0; d$consolidada[tmp==1] <- 1; d$consolidada[tmp==5 | is.na(tmp)==TRUE] <- NA
## d$avanzo <- 0; d$avanzo[tmp==2] <- 1; d$avanzo[tmp==5 | is.na(tmp)==TRUE] <- NA
## d$transita <- 0; d$transita[tmp==3] <- 1; d$transita[tmp==5 | is.na(tmp)==TRUE] <- NA
## d$noDem <- 0; d$noDem[tmp==1] <- 1; d$noDem[tmp==5 | is.na(tmp)==TRUE] <- NA
d$democOK <- 0; d$democOK[tmp<=2] <- 1; d$democOK[tmp==5 | is.na(tmp)==TRUE] <- NA
#
# 18. ¿Está usted a favor o en contra de la reelección consecutiva de legisladores?
tmp <- as.numeric( el09$p18 )
d$legReel <- 0; d$legReel[tmp==1] <- 1; d$legReel[tmp==3 | is.na(tmp)==TRUE] <- NA
#
# 19. ¿Está usted a favor o en contra de la reelección consecutiva de presidentes municipales?
tmp <- as.numeric( el09$p19 )
d$alcReel <- 0; d$alcReel[tmp==1] <- 1; d$alcReel[tmp==3 | is.na(tmp)==TRUE] <- NA
#
# 20. Señale con cuál de las siguientes afirmaciones está más de acuerdo (favor de elegir sólo una). Debe existir la posibilidad de
tmp <- as.numeric( el09$p20 )
## d$reelIndef <- 0; d$reelIndef[tmp==1] <- 1; d$reelIndef[tmp==5 | is.na(tmp)==TRUE] <- NA
## d$reelLim <- 0; d$reelLim[tmp==2] <- 1; d$reelLim[tmp==5 | is.na(tmp)==TRUE] <- NA
## d$reelNoConsec <- 0; d$reelNoConsec[tmp==3] <- 1; d$reelNoConsec[tmp==5 | is.na(tmp)==TRUE] <- NA
## d$reelNunca <- 0; d$reelNunca[tmp==3] <- 1; d$reelNunca[tmp==5 | is.na(tmp)==TRUE] <- NA
d$reelOK <- 0; d$reelOK[tmp<=2] <- 1; d$reelOK[tmp==5 | is.na(tmp)==TRUE] <- NA
#
# 21. Si en 2012 hubiera la posibilidad de reelección para el periodo consecutivo, ¿usted competiría nuevamente para reelegirse en su cargo?
tmp <- as.numeric( el09$p21 )
d$staticAmb <- 0; d$staticAmb[tmp==1] <- 1; d$staticAmb[tmp==3 | is.na(tmp)==TRUE] <- NA
#
# 22. ¿Está usted de acuerdo o en desacuerdo con implementar juicios orales en el sistema de justicia del País?
tmp <- as.numeric( el09$p22 )
d$orales <- 0; d$orales[tmp==1] <- 1; d$orales[tmp==3 | is.na(tmp)==TRUE] <- NA
#
# V. REPRESENTACIÓN Y CÁMARA DE DIPUTADOS 
#
# 23. Por favor enumere las siguientes tareas de la Cámara de Diputados en orden de importancia del 1 al 5, donde 1 es la tarea más importante y 5 la menos importante. (Favor de anotar sólo una vez cada número del 1 al 5) (consider first priority only)
tmp <- el09[, grep("p23", colnames(el09))]; 
d$contrapeso <- 0; d$contrapeso[tmp$p23a==1] <- 1; d$contrapeso[is.na(tmp$p23a)==TRUE] <- NA; 
d$fiscalizar <- 0; d$fiscalizar[tmp$p23b==1] <- 1; d$fiscalizar[is.na(tmp$p23b)==TRUE] <- NA; 
d$representar <- 0; d$representar[tmp$p23c==1] <- 1; d$representar[is.na(tmp$p23c)==TRUE] <- NA; 
d$cooperar <- 0; d$cooperar[tmp$p23d==1] <- 1; d$cooperar[is.na(tmp$p23d)==TRUE] <- NA; 
d$gestionar <- 0; d$gestionar[tmp$p23e==1] <- 1; d$gestionar[is.na(tmp$p23e)==TRUE] <- NA; 
#
# 24. ¿Cuántos diputados deben conformar la Cámara...? (ANOTAR) (turned into few dummies)
tmp <- el09[, grep("p24", colnames(el09))];
tmp$ratio <- tmp$p24a / tmp$p24b
tmp$dmrRatioUp <- 0; tmp$dmrRatioUp[tmp$ratio>1.5 | tmp$p24b==0] <- 1; tmp$dmrRatioUp[tmp$p24a+tmp$p24b==0 | is.na(tmp$p24a)==TRUE] <- NA
tmp$dmrRatioSame <- 0; tmp$dmrRatioSame[tmp$ratio==1.5] <- 1; tmp$dmrRatioSame[tmp$p24a+tmp$p24b==0 | is.na(tmp$p24a)==TRUE] <- NA
tmp$dmrRatioDown <- 0; tmp$dmrRatioDown[tmp$ratio<1.5] <- 1; tmp$dmrRatioDown[tmp$p24a+tmp$p24b==0 | is.na(tmp$p24a)==TRUE] <- NA
tmp$dnDipDown <- 0; tmp$dnDipDown[tmp$p24c<500] <- 1; tmp$dnDipDown[tmp$p24c==0 | is.na(tmp$p24c)==TRUE] <- NA
d$dipMrUp <- tmp$dmrRatioUp
d$dipMrSame <- tmp$dmrRatioSame
d$dipMrDown <- tmp$dmrRatioDown
d$ndipDown <- tmp$dnDipDown
#
# 25. ¿Cuántos senadores deben conformar la Cámara...? (ANOTAR) (turned into even fewer dummies)
tmp <- el09[, grep("p25", colnames(el09))]; 
tmp$dnSenDown <- 0; tmp$dnSenDown[tmp$p25d<128] <- 1; tmp$dnSenDown[tmp$p25d==0 | is.na(tmp$p25d)==TRUE] <- NA
tmp[is.na(tmp)] <- 0
tmp$shMin <- tmp$p25b / (tmp$p25a + tmp$p25b + tmp$p25c)
tmp$shRp <- tmp$p25c / (tmp$p25a + tmp$p25b + tmp$p25c)
tmp$dshMinDown <- 0; tmp$dshMinDown[tmp$shMin<.25] <- 1; tmp$dshMinDown[is.na(tmp$shMin)==TRUE] <- NA;
tmp$dshRPdown <- 0; tmp$dshRPdown[tmp$shRp<.25] <- 1; tmp$dshRPdown[is.na(tmp$shRp)==TRUE] <- NA;
d$senMinDown <- tmp$dshMinDown
d$senRpDown <- tmp$dshRPdown
d$nsenDown <- tmp$dnSenDown
#
# 26. ¿Está usted a favor o en contra de que se elimine el principio de representación proporcional en la Cámara de Diputados?
tmp <- as.numeric( el09$p26 )
d$sinRP <- 0; d$sinRP[tmp==1] <- 1; d$sinRP[tmp==3 | is.na(tmp)==TRUE] <- NA
#
# 27. A la hora de votar, ¿qué debería tomar más en cuenta un legislador?
tmp <- as.numeric( el09$p27 )
d$voteOwn <- 0;  d$voteOwn[tmp==1 | tmp==5] <- 1;  d$voteOwn[tmp==6 | is.na(tmp)==TRUE] <- NA
d$voteDis <- 0;  d$voteDis[tmp==2 | tmp==5] <- 1;  d$voteDis[tmp==6 | is.na(tmp)==TRUE] <- NA
d$votePty <- 0;  d$votePty[tmp==3 | tmp==5] <- 1;  d$votePty[tmp==6 | is.na(tmp)==TRUE] <- NA
d$voteWhip <- 0; d$voteWhip[tmp==4 | tmp==5] <- 1; d$voteWhip[tmp==6 | is.na(tmp)==TRUE] <- NA
#
# 28. ¿Con cuál grupo parlamentario que no sea el suyo preferiría usted que su fracción forme alianzas?
tmp <- as.numeric( el09$p28 )
d$conpan <- 0;  d$conpan[tmp==2] <- 1;  d$conpan[is.na(tmp)==TRUE] <- NA
d$conpri <- 0;  d$conpri[tmp==1] <- 1;  d$conpri[is.na(tmp)==TRUE] <- NA
d$conprd <- 0;  d$conprd[tmp==3] <- 1;  d$conprd[is.na(tmp)==TRUE] <- NA
d$conpt <- 0;  d$conpt[tmp==5] <- 1;  d$conpt[is.na(tmp)==TRUE] <- NA
d$conpvem <- 0;  d$conpvem[tmp==4] <- 1;  d$conpvem[is.na(tmp)==TRUE] <- NA
d$conc <- 0;  d$conc[tmp==6] <- 1;  d$conc[is.na(tmp)==TRUE] <- NA
d$conpanal <- 0;  d$conpanal[tmp==7] <- 1;  d$conpanal[is.na(tmp)==TRUE] <- NA
#
# 29. ¿Qué tanto cabildeo (lobbying) de grupos de interés hay en la Cámara de Diputados? (ordinal to dummy)
tmp <- as.numeric( el09$p29 )
d$hayLobbies <- 0;  d$hayLobbies[tmp==1 | tmp==2] <- 1;  d$conpan[tmp==5 | is.na(tmp)==TRUE] <- NA
#
# 30. ¿Me podría mencionar dos grupos de interés que actualmente cabildean en la Cámara de Diputados? (to dummies)
tmpa <- as.numeric( el09$p30a ); tmpb <- as.numeric( el09$p30b )
d$businessLob <- 0; d$businessLob[tmpa==4 | tmpa==8 | tmpa==23 | tmpa==28 | tmpa==29 | tmpa==30 | tmpa==31 | tmpb==4 | tmpb==8 | tmpb==23 | tmpb==28 | tmpb==29 | tmpb==30 | tmpb==31] <- 1; d$businessLob[tmpa==1] <- NA 
d$laborLob <- 0; d$laborLob[tmpa==9 | tmpa==27 | tmpb==9 | tmpb==27] <- 1; d$laborLob[tmpa==1] <- NA
d$ruralLob <- 0; d$ruralLob[tmpa==11 | tmpa==18 | tmpa==21 | tmpb==11 | tmpb==18 | tmpb==21] <- 1; d$ruralLob[tmpa==1] <- NA
d$tvLob <- 0; d$tvLob[tmpa==10 | tmpb==10] <- 1; d$tvLob[tmpa==1] <- NA
d$ptyLob <- 0; d$ptyLob[tmpa==12 | tmpa==13 | tmpa==14 | tmpa==15 | tmpa==16 | tmpa==17 | tmpa==19 | tmpb==12 | tmpb==13 | tmpb==14 | tmpb==15 | tmpb==16 | tmpb==17 | tmpb==19] <- 1; d$ptyLob[tmpa==1] <- NA
d$shcpLob <- 0; d$shcpLob[tmpa==12 | tmpa==25 | tmpb==12 | tmpb==25] <- 1; d$shcpLob[tmpa==1] <- NA
#
# 31. Para lograr acuerdos legislativos, ¿qué tanto coopera el grupo parlamentario del...?
tmp <- as.numeric( el09$p31b )
d$colabpan <- 0; d$colabpan[tmp==1] <- 1; d$colabpan[is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p31a )
d$colabpri <- 0; d$colabpri[tmp==1] <- 1; d$colabpri[is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p31c )
d$colabprd <- 0; d$colabprd[tmp==1] <- 1; d$colabprd[is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p31e )
d$colabpt <- 0; d$colabpt[tmp==1] <- 1; d$colabpt[is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p31d )
d$colabpvem <- 0; d$colabpvem[tmp==1] <- 1; d$colabpvem[is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p31f )
d$colabc <- 0; d$colabc[tmp==1] <- 1; d$colabc[is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p31g )
d$colabpanal <- 0; d$colabpanal[tmp==1] <- 1; d$colabpanal[is.na(tmp)==TRUE] <- NA
#
# VI. ELECCIONES Y CAMPAÑAS 
#
# 32. ¿Está usted a favor o en contra de...?	1) A favor	2) En contra
tmp <- as.numeric( el09$p32a )
d$menosApart <- 0; d$menosApart[tmp==1] <- 1; d$menosApart[tmp==3 | is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p32b )
d$referend <- 0; d$referend[tmp==1] <- 1; d$referend[tmp==3 | is.na(tmp)==TRUE] <- NA
#
# 33. En una escala del 1 al 5, donde 1 es un financiamiento público y 5 es un financiamiento privado, ¿cómo cree usted que debe ser el financiamiento a los partidos políticos?
tmp <- as.numeric( el09$p33 )
d$privOK <- 0; d$privOK[tmp>=3] <- 1; d$privOK[is.na(tmp)==TRUE] <- NA
#
# 34. (Favor de contestar sólo los diputados de mayoría relativa) Las elecciones del 5 de julio, en el distrito donde usted fue electo(a) diputado(a), fueron: (ignore NAs, all zeroes means respondent mentioned no margin)
tmp <- as.numeric( el09$p34 )
d$mg5 <- 0; d$mg5[tmp==1] <- 1; 
d$mg10 <- 0; d$mg10[tmp==2] <- 1;
d$mg20 <- 0; d$mg20[tmp==3] <- 1;
d$mgMore <- 0; d$mgMore[tmp==4] <- 1;
#
# 35. ¿Cómo evalúa el trabajo realizado por el IFE en 2009 en los siguientes aspectos?
tmp <- as.numeric( el09$p35a )
d$padronOK <- 0; d$padronOK[tmp==1 | tmp==2] <- 1; d$padronOK[tmp==6 | is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p35b )
d$orgOK <- 0; d$orgOK[tmp==1 | tmp==2] <- 1; d$orgOK[tmp==6 | is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p35c )
d$confOK <- 0; d$confOK[tmp==1 | tmp==2] <- 1; d$confOK[tmp==6 | is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p35d )
d$fiscOK <- 0; d$fiscOK[tmp==1 | tmp==2] <- 1; d$fiscOK[tmp==6 | is.na(tmp)==TRUE] <- NA
#
# 36. En general, ¿cómo evalúa el trabajo realizado por el Consejero Presidente del IFE, Leonardo Valdés? 
tmp <- as.numeric( el09$p36 )
d$valdesOK <- 0; d$valdesOK[tmp==1 | tmp==2] <- 1; d$valdesOK[tmp==6 | is.na(tmp)==TRUE] <- NA
#
# VII. GOBIERNO DE FELIPE CALDERÓN
#
# 37. En general, ¿cómo evalúa el trabajo de Felipe Calderón como Presidente?
tmp <- as.numeric( el09$p37 )
d$fchOK <- 0; d$fchOK[tmp==1 | tmp==2] <- 1; d$fchOK[tmp==6 | is.na(tmp)==TRUE] <- NA
#
# 38. En general, ¿cómo evalúa al Gobierno de Felipe Calderón en…?
tmp <- as.numeric( el09$p38a )
d$ecoOK <- 0; d$ecoOK[tmp==1 | tmp==2] <- 1; d$ecoOK[tmp==6 | is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p38b )
d$polOK <- 0; d$polOK[tmp==1 | tmp==2] <- 1; d$polOK[tmp==6 | is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p38c )
d$saludOK <- 0; d$saludOK[tmp==1 | tmp==2] <- 1; d$saludOK[tmp==6 | is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p38d )
d$pobrezaOK <- 0; d$pobrezaOK[tmp==1 | tmp==2] <- 1; d$pobrezaOK[tmp==6 | is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p38e )
d$rriiOK <- 0; d$rriiOK[tmp==1 | tmp==2] <- 1; d$rriiOK[tmp==6 | is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p38f )
d$seguridadOK <- 0; d$seguridadOK[tmp==1 | tmp==2] <- 1; d$seguridadOK[tmp==6 | is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p38g )
d$corrupOK <- 0; d$corrupOK[tmp==1 | tmp==2] <- 1; d$corrupOK[tmp==6 | is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p38h )
d$narcoOK <- 0; d$narcoOK[tmp==1 | tmp==2] <- 1; d$narcoOK[tmp==6 | is.na(tmp)==TRUE] <- NA
#
# 39. ¿Cómo considera que son las relaciones entre el Ejecutivo y el Legislativo?
tmp <- as.numeric( el09$p39 )
d$exLegOK <- 0; d$exLegOK[tmp==1 | tmp==2] <- 1; d$exLegOK[tmp==6 | is.na(tmp)==TRUE] <- NA
#
# 40. En una escala del 0 al 10, donde 0 significa “muy mal” y 10 “muy bien”, ¿cómo calificaría el desempeño de los siguientes secretarios y funcionarios del gabinete presidencial?
tmp <- as.numeric( el09$p40a )
d$sagarpaOK <- 0; d$sagarpaOK[tmp>8] <- 1; d$sagarpaOK[is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p40b )
d$sctOK <- 0; d$sctOK[tmp>8] <- 1; d$sctOK[is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p40c )
d$sedenaOK <- 0; d$sedenaOK[tmp>8] <- 1; d$sedenaOK[is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p40d )
d$sedesolOK <- 0; d$sedesolOK[tmp>8] <- 1; d$sedesolOK[is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p40e )
d$seOK <- 0; d$seOK[tmp>8] <- 1; d$seOK[is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p40f )
d$sepOK <- 0; d$sepOK[tmp>8] <- 1; d$sepOK[is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p40g )
d$senerOK <- 0; d$senerOK[tmp>8] <- 1; d$senerOK[is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p40h )
d$sgOK <- 0; d$sgOK[tmp>8] <- 1; d$sgOK[is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p40i )
d$shcpOK <- 0; d$shcpOK[tmp>8] <- 1; d$shcpOK[is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p40j )
d$marinaOK <- 0; d$marinaOK[tmp>8] <- 1; d$marinaOK[is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p40k )
d$semarnapOK <- 0; d$semarnapOK[tmp>8] <- 1; d$semarnapOK[is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p40l )
d$sreOK <- 0; d$sreOK[tmp>8] <- 1; d$sreOK[is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p40m )
d$ssOK <- 0; d$ssOK[tmp>8] <- 1; d$ssOK[is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p40n )
d$sspOK <- 0; d$sspOK[tmp>8] <- 1; d$sspOK[is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p40o )
d$stpsOK <- 0; d$stpsOK[tmp>8] <- 1; d$stpsOK[is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p40p )
d$pgrOK <- 0; d$pgrOK[tmp>8] <- 1; d$pgrOK[is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p40q )
d$imssOK <- 0; d$imssOK[tmp>8] <- 1; d$imssOK[is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p40r )
d$pemexOK <- 0; d$pemexOK[tmp>8] <- 1; d$pemexOK[is.na(tmp)==TRUE] <- NA
#
# VIII. IDEOLOGÍA Y VALORES
#
# 41. ¿Está usted de acuerdo o en desacuerdo con las siguientes afirmaciones? 
tmp <- as.numeric( el09$p41a )
d$freetradeOK <- 0; d$freetradeOK[tmp==1 | tmp==2] <- 1; d$freetradeOK[tmp==5 | is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p41b )
d$tariffsOK <- 0; d$tariffsOK[tmp==1 | tmp==2] <- 1; d$tariffsOK[tmp==5 | is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p41c )
d$progressiveOK <- 0; d$progressiveOK[tmp==1 | tmp==2] <- 1; d$progressiveOK[tmp==5 | is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p41d )
d$mercadoOK <- 0; d$mercadoOK[tmp==1 | tmp==2] <- 1; d$mercadoOK[tmp==5 | is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p41e )
d$abortoOK <- 0; d$abortoOK[tmp==3 | tmp==4] <- 1; d$abortoOK[tmp==5 | is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p41f )
d$penamuerteOK <- 0; d$penamuerteOK[tmp==1 | tmp==2] <- 1; d$penamuerteOK[tmp==5 | is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p41g )
d$gayUnionOK <- 0; d$gayUnionOK[tmp==1 | tmp==2] <- 1; d$gayUnionOK[tmp==5 | is.na(tmp)==TRUE] <- NA
#
# 42. En términos generales, para describir su posición política, ¿en qué punto de la escala “Izquierda” y “Derecha” se ubicaría usted?
tmp <- as.numeric( el09$p42 )
d$selfi <- 0;  d$selfi[tmp==1] <- 1; d$selfi[tmp==6 | is.na(tmp)==TRUE] <- NA
d$selfci <- 0; d$selfci[tmp==2] <- 1; d$selfci[tmp==6 | is.na(tmp)==TRUE] <- NA
d$selfc <- 0;  d$selfc[tmp==3] <- 1; d$selfc[tmp==6 | is.na(tmp)==TRUE] <- NA
d$selfcd <- 0; d$selfcd[tmp==4] <- 1; d$selfcd[tmp==6 | is.na(tmp)==TRUE] <- NA
d$selfd <- 0;  d$selfd[tmp==5] <- 1; d$selfd[tmp==6 | is.na(tmp)==TRUE] <- NA
#
# 43. En esa misma escala de Izquierda-Derecha, ¿cómo considera a los siguientes partidos?
tmp <- as.numeric( el09$p43a )
d$pani <- 0;  d$pani[tmp==1] <- 1; d$pani[tmp==6 | is.na(tmp)==TRUE] <- NA
d$panci <- 0; d$panci[tmp==2] <- 1; d$panci[tmp==6 | is.na(tmp)==TRUE] <- NA
d$panc <- 0;  d$panc[tmp==3] <- 1; d$panc[tmp==6 | is.na(tmp)==TRUE] <- NA
d$pancd <- 0; d$pancd[tmp==4] <- 1; d$pancd[tmp==6 | is.na(tmp)==TRUE] <- NA
d$pand <- 0;  d$pand[tmp==5] <- 1; d$pand[tmp==6 | is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p43b )
d$prii <- 0;  d$prii[tmp==1] <- 1; d$prii[tmp==6 | is.na(tmp)==TRUE] <- NA
d$prici <- 0; d$prici[tmp==2] <- 1; d$prici[tmp==6 | is.na(tmp)==TRUE] <- NA
d$pric <- 0;  d$pric[tmp==3] <- 1; d$pric[tmp==6 | is.na(tmp)==TRUE] <- NA
d$pricd <- 0; d$pricd[tmp==4] <- 1; d$pricd[tmp==6 | is.na(tmp)==TRUE] <- NA
d$prid <- 0;  d$prid[tmp==5] <- 1; d$prid[tmp==6 | is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p43c )
d$prdi <- 0;  d$prdi[tmp==1] <- 1; d$prdi[tmp==6 | is.na(tmp)==TRUE] <- NA
d$prdci <- 0; d$prdci[tmp==2] <- 1; d$prdci[tmp==6 | is.na(tmp)==TRUE] <- NA
d$prdc <- 0;  d$prdc[tmp==3] <- 1; d$prdc[tmp==6 | is.na(tmp)==TRUE] <- NA
d$prdcd <- 0; d$prdcd[tmp==4] <- 1; d$prdcd[tmp==6 | is.na(tmp)==TRUE] <- NA
d$prdd <- 0;  d$prdd[tmp==5] <- 1; d$prdd[tmp==6 | is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p43d )
d$pti <- 0;  d$pti[tmp==1] <- 1; d$pti[tmp==6 | is.na(tmp)==TRUE] <- NA
d$ptci <- 0; d$ptci[tmp==2] <- 1; d$ptci[tmp==6 | is.na(tmp)==TRUE] <- NA
d$ptc <- 0;  d$ptc[tmp==3] <- 1; d$ptc[tmp==6 | is.na(tmp)==TRUE] <- NA
d$ptcd <- 0; d$ptcd[tmp==4] <- 1; d$ptcd[tmp==6 | is.na(tmp)==TRUE] <- NA
d$ptd <- 0;  d$ptd[tmp==5] <- 1; d$ptd[tmp==6 | is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p43e )
d$pvemi <- 0;  d$pvemi[tmp==1] <- 1; d$pvemi[tmp==6 | is.na(tmp)==TRUE] <- NA
d$pvemci <- 0; d$pvemci[tmp==2] <- 1; d$pvemci[tmp==6 | is.na(tmp)==TRUE] <- NA
d$pvemc <- 0;  d$pvemc[tmp==3] <- 1; d$pvemc[tmp==6 | is.na(tmp)==TRUE] <- NA
d$pvemcd <- 0; d$pvemcd[tmp==4] <- 1; d$pvemcd[tmp==6 | is.na(tmp)==TRUE] <- NA
d$pvemd <- 0;  d$pvemd[tmp==5] <- 1; d$pvemd[tmp==6 | is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p43f )
d$ci <- 0;  d$ci[tmp==1] <- 1; d$ci[tmp==6 | is.na(tmp)==TRUE] <- NA
d$cci <- 0; d$cci[tmp==2] <- 1; d$cci[tmp==6 | is.na(tmp)==TRUE] <- NA
d$cc <- 0;  d$cc[tmp==3] <- 1; d$cc[tmp==6 | is.na(tmp)==TRUE] <- NA
d$ccd <- 0; d$ccd[tmp==4] <- 1; d$ccd[tmp==6 | is.na(tmp)==TRUE] <- NA
d$cd <- 0;  d$cd[tmp==5] <- 1; d$cd[tmp==6 | is.na(tmp)==TRUE] <- NA
tmp <- as.numeric( el09$p43g )
d$panali <- 0;  d$panali[tmp==1] <- 1; d$panali[tmp==6 | is.na(tmp)==TRUE] <- NA
d$panalci <- 0; d$panalci[tmp==2] <- 1; d$panalci[tmp==6 | is.na(tmp)==TRUE] <- NA
d$panalc <- 0;  d$panalc[tmp==3] <- 1; d$panalc[tmp==6 | is.na(tmp)==TRUE] <- NA
d$panalcd <- 0; d$panalcd[tmp==4] <- 1; d$panalcd[tmp==6 | is.na(tmp)==TRUE] <- NA
d$panald <- 0;  d$panald[tmp==5] <- 1; d$panald[tmp==6 | is.na(tmp)==TRUE] <- NA
#
# 44. En temas sociales como el aborto y la homosexualidad, ¿usted cómo se considera?
tmp <- as.numeric( el09$p44 )
d$muyLib <- 0;  d$muyLib[tmp==1] <- 1; d$muyLib[tmp==6 | is.na(tmp)==TRUE] <- NA
d$lib <- 0;     d$lib[tmp==2] <- 1; d$lib[tmp==6 | is.na(tmp)==TRUE] <- NA
d$moder <- 0;   d$moder[tmp==3] <- 1; d$moder[tmp==6 | is.na(tmp)==TRUE] <- NA
d$con <- 0;     d$con[tmp==4] <- 1; d$con[tmp==6 | is.na(tmp)==TRUE] <- NA
d$muyCon <- 0;  d$muyCon[tmp==5] <- 1; d$muyCon[tmp==6 | is.na(tmp)==TRUE] <- NA
#
# IX. EXPERIENCIA POLÍTICA
#
# 45. ¿Ha ocupado con anterioridad otros cargos de elección popular?  
tmp <- as.numeric( el09$p45 )
d$experienced <- 0;  d$experienced[tmp==1] <- 1; d$experienced[tmp==3 | is.na(tmp)==TRUE] <- NA
#
# 46. ¿Es usted presidente o secretario de alguna comisión legislativa?
tmp <- as.numeric( el09$p46 )
d$chair <- 0;  d$chair[tmp==1] <- 1; d$chair[tmp==3 | is.na(tmp)==TRUE] <- NA
#
# 47. ¿Cuenta usted con oficina de atención al público en su distrito electoral?
tmp <- as.numeric( el09$p47 )
d$casework <- 0;  d$casework[tmp==1] <- 1; d$casework[tmp==3 | is.na(tmp)==TRUE] <- NA
#
# X. MEDIOS INFORMATIVOS
#
# 48. ¿Cómo considera que los medios de comunicación están cubriendo las actividades del Congreso?
tmp <- as.numeric( el09$p48 )
d$relTvOK <- 0;  d$relTvOK[tmp<=2] <- 1; d$relTvOK[tmp==6 | is.na(tmp)==TRUE] <- NA
#
# 49. ¿Cree usted que los medios de comunicación cubren de manera adecuada o inadecuada el quehacer legislativo?
tmp <- as.numeric( el09$p49 )
d$tvCoverOK <- 0;  d$tvCoverOK[tmp==1] <- 1; d$tvCoverOK[tmp==3 | is.na(tmp)==TRUE] <- NA
#
# 50. ¿Qué considera que deben cubrir los medios de comunicación acerca del Congreso?
tmpa <- as.numeric( el09$p50a ); tmpb <- as.numeric( el09$p50b )
d$procedureOntv <- 0; d$procedureOntv[tmpa==1 | tmpb==1 | tmpa==6 | tmpb==6 | tmpa==7 | tmpb==7 | tmpa==11 | tmpb==11 | tmpa==20 | tmpb==20] <- 1; d$procedureOntv[is.na(tmp)==TRUE] <- NA
d$selfOnTv <- 0; d$selfOnTv[tmpa==2 | tmpb==2 | tmpa==3 | tmpb==3 | tmpa==5 | tmpb==5 | tmpa==10 | tmpb==10 | tmpa==15 | tmpb==15] <- 1; d$selfOnTv[is.na(tmp)==TRUE] <- NA
d$balancedOnTv <- 0; d$balancedOnTv[tmpa==4 | tmpb==4 | tmpa==8 | tmpb==8 | tmpa==13 | tmpb==13 | tmpa==21 | tmpb==21 | tmpa==22 | tmpb==22] <- 1; d$balancedOnTv[is.na(tmp)==TRUE] <- NA
#
# XI. DATOS GENERALES
# A. Sexo
tmp <- as.numeric( el09$a )
d$fem <- 0; d$fem[tmp==2] <- 1
#
# B. Edad
d$age <- as.numeric( el09$b )
#
# C. Nivel de escolaridad: 
d$escol <- as.numeric( el09$c )
## d$escPrepa <- 0; d$escPrepa[tmp==3 | tmp==4 | tmp==5 | tmp==6] <- 1 # prepa or more
## d$escLic <- 0; d$escLic[                 tmp==4 | tmp==5 | tmp==6] <- 1 # licenciatura or more
## d$escPosg <- 0; d$escPosg[                            tmp==5 | tmp==6] <- 1 # maestría or more
#
# D. Forma en la que fue electo:
d$maj <- as.numeric( el09$d ) - 1; d$maj[d$maj==2] <- NA
#
# E. Grupo parlamentario al que pertenece
tmp <- as.numeric( el09$e )
d$pan <- 0; d$pan[tmp==2] <- 1
d$pri <- 0; d$pri[tmp==1] <- 1
d$prd <- 0; d$prd[tmp==3] <- 1
d$pt <- 0; d$pt[tmp==5] <- 1
d$pvem <- 0; d$pvem[tmp==4] <- 1
d$c <- 0; d$c[tmp==6] <- 1
d$panal <- 0; d$panal[tmp==7] <- 1
#d$indep <- 0; d$indep[tmp==8] <- 1
#
# F. Tiempo de afiliación a su actual partido
d$yrsAfil <- as.numeric(el09$f)
#
# G. Antes de pertenecer a su actual grupo parlamentario, ¿pertenecía a algún otro partido político?
tmp <- as.numeric( el09$g )
d$switcher <- 0;  d$switcher[tmp==2] <- 1; d$switcher[tmp==3 | is.na(tmp)==TRUE] <- NA
#
# H. ¿En qué estado de la República fue electo como legislador?
d$edon <- as.numeric( el09$h ) - 1; d$edon[d$edon==0] <- NA
#
rm(tmp,tmpa,tmpb)
#
# sociodemog and other personal traits
select <- which( colnames(d) %in% c("folio", "age", "edon", "fem", "escol", "maj", "pan", "pri", "prd", "pt", "pvem", "c", "panal", "yrsAfil", "switcher", "mg5", "mg10", "mg20", "mgMore", "experienced", "chair", "casework") )
d.id <- d[, select]
d <- d[, -select]
rm(select)
#
# pty with my codes
tmp <- as.numeric( el09$e )
d.id$pty <- rep(NA, length(tmp))
d.id$pty[tmp==2] <- 1 #pan
d.id$pty[tmp==1] <- 2 #pri
d.id$pty[tmp==3] <- 3 #prd
d.id$pty[tmp==5] <- 4 #pt
d.id$pty[tmp==4] <- 5 #pvem
d.id$pty[tmp==6] <- 6 #c
d.id$pty[tmp==7] <- 7 #panal
rm(tmp)
#
## Change NAs to zero to describe data
d[d==0] <- -1;
d[is.na(d)==TRUE] <- 0
# do same with d.id
#
## DEPUTY'S ITEM RESPONSE RATE
rr <- apply(d, 1, function(x) sum(x==0))
max(round(rr/ncol(d),2))
## DROP DIPUTADOS WHO ANSWERED LESS THAN 10% OF ALL Qs
# no such cases
## DROP UNCONTESTED AND UNIFORMATIVE Qs WITH MINORITY < 2.5%
mg <- apply(d, 2, mean)
mg[order(-mg)]
# d[, mg < -.975] <- NULL  ## None, it seems
rm(rr,mg)
#
# rename to dummy object
d.dum <- d

# bridge stimuli only
d.br <- d[, c("orden","cfePriv", "pemexPriv")]
#
# rename dummy columns
colnames(d.br) <- paste("d.", colnames(d.br), sep = "")
#
# re-adopt original 1:2 coding with zero for missing
d.br[d.br==1] <- 2; d.br[d.br==-1] <- 1 
# add thermometer scales
tmp <- as.numeric( el09$p17 )
tmp[tmp==5 | is.na(tmp)==TRUE] <- 0
d.br$t.demProg <- tmp
#
tmp <- as.numeric( el09$p35c )
tmp[tmp==6 | is.na(tmp)==TRUE] <- 0
d.br$t.ifeConf <- tmp
#
tmp <- as.numeric( el09$p37 )
tmp[tmp==6 | is.na(tmp)==TRUE] <- 0
d.br$t.fchApprov <- tmp
#
tmp <- as.numeric( el09$p41a )
tmp[tmp==5 | is.na(tmp)==TRUE] <- 0
d.br$t.freeTradeOK <- tmp
#
## tmp <- as.numeric( el09$p41b )
## tmp[tmp==5 | is.na(tmp)==TRUE] <- 0
## d.br$t.tariffsOK <- tmp
## #
tmp <- as.numeric( el09$p41d )
tmp[tmp==5 | is.na(tmp)==TRUE] <- 0
d.br$t.freeMktOK <- tmp
#
tmp <- as.numeric( el09$p41e )
tmp[tmp==5 | is.na(tmp)==TRUE] <- 0
d.br$t.abortionOK <- tmp
#
tmp <- -as.numeric( el09$p41g ) + 5
tmp[is.na(tmp)==TRUE] <- 0
d.br$t.gayUnionOK <- tmp
#
tmp <- as.numeric( el09$p44 )
tmp[tmp==6 | is.na(tmp)==TRUE] <- 0
d.br$t.libCon <- tmp
#
tmp <- as.numeric( el09$p42 )
tmp[tmp==6 | is.na(tmp)==TRUE] <- 0
d.br$t.leftRight <- tmp
#
rm(tmp)
rownames(d.br) <- paste("lg", 1:nrow(m), sep = "")
#
## # drop calderón approval question --- seems too close to party
## d.br <- d.br[, -which(colnames(d.br)=="t.fchApprov")]

# all stimuli with thermometers redone
# m is temporary
m <- d[, c("prioEner", "prioLab", "prioEdo", "prioCampo", "prioHda", "prioSalud", "prioEduc" , "prioJust" , "orden" ,"derechos","recaudar","incentivar", "costo", "confianza", "cfePriv", "pemexPriv", "golfoPriv", "golfoPara", "sqPetrOk", "masAedos", "edosRecauden", "masGasto", "menosGasto", "ivaUnico", "ivaAlim", "ivaPobres", "legReel", "alcReel", "reelOK", "staticAmb", "orales", "contrapeso","fiscalizar", "representar", "cooperar", "gestionar", "dipMrUp", "dipMrSame", "dipMrDown", "ndipDown", "senMinDown", "senRpDown", "nsenDown", "sinRP", "voteOwn", "voteDis", "votePty", "voteWhip", "conpan", "conpri", "conprd", "conpt", "conpvem", "conc", "conpanal", "businessLob", "laborLob", "ruralLob", "tvLob", "ptyLob", "shcpLob", "menosApart", "referend", "tvCoverOK", "procedureOntv", "selfOnTv", "balancedOnTv")]
m[m==1] <- 2; m[m==-1] <- 1 # re-adopt original 1:2 coding with zero for missing
head(m) #debug
# re-include thermometer scales
tmp <- as.numeric( el09$p17 )
tmp[tmp==5 | is.na(tmp)==TRUE] <- 0
m$demProg4 <- tmp
#
tmp <- as.numeric( el09$p29 )
tmp[tmp==5 | is.na(tmp)==TRUE] <- 0
m$lobbying <- tmp
#
tmp <- as.numeric( el09$p31a )
tmp[tmp==5 | is.na(tmp)==TRUE] <- 0
m$coopPri <- tmp
#
tmp <- as.numeric( el09$p31b )
tmp[tmp==5 | is.na(tmp)==TRUE] <- 0
m$coopPan <- tmp
#
tmp <- as.numeric( el09$p31c )
tmp[tmp==5 | is.na(tmp)==TRUE] <- 0
m$coopPrd <- tmp
#
tmp <- as.numeric( el09$p31d )
tmp[tmp==5 | is.na(tmp)==TRUE] <- 0
m$coopPvem <- tmp
#
tmp <- as.numeric( el09$p31e )
tmp[tmp==5 | is.na(tmp)==TRUE] <- 0
m$coopPt <- tmp
#
tmp <- as.numeric( el09$p31f )
tmp[tmp==5 | is.na(tmp)==TRUE] <- 0
m$coopC <- tmp
#
tmp <- as.numeric( el09$p31g )
tmp[tmp==5 | is.na(tmp)==TRUE] <- 0
m$coopPanal <- tmp
#
tmp <- as.numeric( el09$p33 )
tmp[tmp==5 | is.na(tmp)==TRUE] <- 0
m$privMoney <- tmp
#
tmp <- el09$p34
tmp <- mapvalues(as.numeric(tmp), from = 1:5, to =  c(1:4,NA))
d.id$t.mg <- tmp
#
tmp <- as.numeric( el09$p35a )
tmp[tmp==6 | is.na(tmp)==TRUE] <- 0
m$ifePadron <- tmp
#
tmp <- as.numeric( el09$p35b )
tmp[tmp==6 | is.na(tmp)==TRUE] <- 0
m$ifeOrg <- tmp
#
tmp <- as.numeric( el09$p35c )
tmp[tmp==6 | is.na(tmp)==TRUE] <- 0
m$ifeConf <- tmp
#
tmp <- as.numeric( el09$p35d )
tmp[tmp==6 | is.na(tmp)==TRUE] <- 0
m$ifeFisc <- tmp
#
tmp <- as.numeric( el09$p36 )
tmp[tmp==6 | is.na(tmp)==TRUE] <- 0
m$valdes <- tmp
#
tmp <- as.numeric( el09$p37 )
tmp[tmp==6 | is.na(tmp)==TRUE] <- 0
m$fchApprov5 <- tmp
#
tmp <- as.numeric( el09$p38a )
tmp[tmp==6 | is.na(tmp)==TRUE] <- 0
m$eco <- tmp
#
tmp <- as.numeric( el09$p38b )
tmp[tmp==6 | is.na(tmp)==TRUE] <- 0
m$pol <- tmp
#
tmp <- as.numeric( el09$p38c )
tmp[tmp==6 | is.na(tmp)==TRUE] <- 0
m$salud <- tmp
#
tmp <- as.numeric( el09$p38d )
tmp[tmp==6 | is.na(tmp)==TRUE] <- 0
m$pobr <- tmp
#
tmp <- as.numeric( el09$p38e )
tmp[tmp==6 | is.na(tmp)==TRUE] <- 0
m$rrii <- tmp
#
tmp <- as.numeric( el09$p38f )
tmp[tmp==6 | is.na(tmp)==TRUE] <- 0
m$segpub <- tmp
#
tmp <- as.numeric( el09$p38g )
tmp[tmp==6 | is.na(tmp)==TRUE] <- 0
m$corr <- tmp
#
tmp <- as.numeric( el09$p38h )
tmp[tmp==6 | is.na(tmp)==TRUE] <- 0
m$narco <- tmp
#
tmp <- as.numeric( el09$p39 )
tmp[tmp==6 | is.na(tmp)==TRUE] <- 0
m$exLeg <- tmp
#
tmp <- as.numeric( el09$p40a )
tmp <- tmp+1
tmp[is.na(tmp)==TRUE] <- 0
m$sagarpa <- tmp
#
tmp <- as.numeric( el09$p40b )
tmp <- tmp+1
tmp[is.na(tmp)==TRUE] <- 0
m$sct <- tmp
#
tmp <- as.numeric( el09$p40c )
tmp <- tmp+1
tmp[is.na(tmp)==TRUE] <- 0
m$sedena <- tmp
#
tmp <- as.numeric( el09$p40d )
tmp <- tmp+1
tmp[is.na(tmp)==TRUE] <- 0
m$sedesol <- tmp
#
tmp <- as.numeric( el09$p40e )
tmp <- tmp+1
tmp[is.na(tmp)==TRUE] <- 0
m$se <- tmp
#
tmp <- as.numeric( el09$p40f )
tmp <- tmp+1
tmp[is.na(tmp)==TRUE] <- 0
m$sep <- tmp
#
tmp <- as.numeric( el09$p40g )
tmp <- tmp+1
tmp[is.na(tmp)==TRUE] <- 0
m$sener <- tmp
#
tmp <- as.numeric( el09$p40h )
tmp <- tmp+1
tmp[is.na(tmp)==TRUE] <- 0
m$sg <- tmp
#
tmp <- as.numeric( el09$p40i )
tmp <- tmp+1
tmp[is.na(tmp)==TRUE] <- 0
m$shcp <- tmp
#
tmp <- as.numeric( el09$p40j )
tmp <- tmp+1
tmp[is.na(tmp)==TRUE] <- 0
m$semar <- tmp
#
tmp <- as.numeric( el09$p40k )
tmp <- tmp+1
tmp[is.na(tmp)==TRUE] <- 0
m$semarnap <- tmp
#
tmp <- as.numeric( el09$p40l )
tmp <- tmp+1
tmp[is.na(tmp)==TRUE] <- 0
m$sre <- tmp
#
tmp <- as.numeric( el09$p40m )
tmp <- tmp+1
tmp[is.na(tmp)==TRUE] <- 0
m$ss <- tmp
#
tmp <- as.numeric( el09$p40n )
tmp <- tmp+1
tmp[is.na(tmp)==TRUE] <- 0
m$ssp <- tmp
#
tmp <- as.numeric( el09$p40o )
tmp <- tmp+1
tmp[is.na(tmp)==TRUE] <- 0
m$st <- tmp
#
tmp <- as.numeric( el09$p40p )
tmp <- tmp+1
tmp[is.na(tmp)==TRUE] <- 0
m$pgr <- tmp
#
tmp <- as.numeric( el09$p40q )
tmp <- tmp+1
tmp[is.na(tmp)==TRUE] <- 0
m$imss <- tmp
#
tmp <- as.numeric( el09$p40r )
tmp <- tmp+1
tmp[is.na(tmp)==TRUE] <- 0
m$pemex <- tmp
#
tmp <- as.numeric( el09$p41a )
tmp[tmp==5 | is.na(tmp)==TRUE] <- 0
m$freeTradeOK4 <- tmp
#
tmp <- as.numeric( el09$p41b )
tmp[tmp==5 | is.na(tmp)==TRUE] <- 0
m$tariffsOK4 <- tmp
#
tmp <- as.numeric( el09$p41c )
tmp[tmp==5 | is.na(tmp)==TRUE] <- 0
m$progre <- tmp
#
tmp <- as.numeric( el09$p41d )
tmp[tmp==5 | is.na(tmp)==TRUE] <- 0
m$freeMkt <- tmp
#
tmp <- as.numeric( el09$p41e )
tmp[tmp==5 | is.na(tmp)==TRUE] <- 0
m$abortionOK4 <- tmp
#
tmp <- as.numeric( el09$p41f )
tmp[tmp==5 | is.na(tmp)==TRUE] <- 0
m$death <- tmp
#
tmp <- as.numeric( el09$p41g )
tmp[tmp==5 | is.na(tmp)==TRUE] <- 0
m$gayUnionOK4 <- tmp
#
tmp <- as.numeric( el09$p42 )
tmp[tmp==6 | is.na(tmp)==TRUE] <- 0
m$leftRight5 <- tmp
#
tmp <- as.numeric( el09$p43a )
tmp[tmp==6 | is.na(tmp)==TRUE] <- 0
m$panlr <- tmp
#
tmp <- as.numeric( el09$p43b )
tmp[tmp==6 | is.na(tmp)==TRUE] <- 0
m$prilr <- tmp
#
tmp <- as.numeric( el09$p43c )
tmp[tmp==6 | is.na(tmp)==TRUE] <- 0
m$prdlr <- tmp
#
tmp <- as.numeric( el09$p43d )
tmp[tmp==6 | is.na(tmp)==TRUE] <- 0
m$pvemlr <- tmp
#
tmp <- as.numeric( el09$p43e )
tmp[tmp==6 | is.na(tmp)==TRUE] <- 0
m$ptlr <- tmp
#
tmp <- as.numeric( el09$p43f )
tmp[tmp==6 | is.na(tmp)==TRUE] <- 0
m$clr <- tmp
#
tmp <- as.numeric( el09$p43g )
tmp[tmp==6 | is.na(tmp)==TRUE] <- 0
m$panallr <- tmp
#
tmp <- as.numeric( el09$p44 )
tmp[tmp==6 | is.na(tmp)==TRUE] <- 0
m$libCon5 <- tmp
#
tmp <- as.numeric( el09$p48 )
tmp[tmp==6 | is.na(tmp)==TRUE] <- 0
m$medCong5 <- tmp
#
# Recover stuff left out originally by turning it into thermometers
# 12. ¿Qué porcentaje del presupuesto de egresos asignaría usted a las siguientes áreas? (recoded to always add to 1) TRANSFORMED TO 1-10 THERMOMETER 
tmp <- el09[,grep(pattern = "p12", x = colnames(el09))]
tmp[is.na(tmp)] <- 0 # assumes NAs are zeroes
tmp <- round( tmp*100/apply(tmp, 1, sum), 0)
tmp <- round(tmp/10, 0) + 1 # 1-11 scale (added 1 so 0=NA absent)
tmp[is.na(tmp)==TRUE] <- 0
colnames(tmp) <- c("shEduc","shSalud","shNarco","shEdos","shFobaproa","shIPF","shMedAmb","shDefensa","shPobres","shIfePP","shOth")
m <- cbind(m,tmp)
# 13. Considerando el actual presupuesto, ¿en qué porcentaje aumentaría o reduciría el gasto público total?
tmp <- data.frame(menos=-el09$p13b,mas=el09$p13a)
tmp[is.na(tmp)==TRUE] <- 0
tmp <- apply(tmp,1,sum)
tmp <- round(tmp/10,0) + 11 # 21 point scale with 11 for no change
tmp[tmp==11] <- 0 # missing values
tmp[as.numeric(el09$p13)==3] <- 11 # revover cases of no change
m$pctChgBudg <- tmp
#
# drop calderón approval questions --- seem too close to party (keep one only, perhaps)
m <- m[, -which(colnames(m) %in% c("eco", "pol", "salud", "pobr", "rrii", "segpub", "corr", "narco", "sagarpa", "sct", "sedena", "sedesol", "se", "sep", "sener", "sg", "shcp", "semar", "semarnap", "sre", "ss", "ssp", "st", "pgr", "imss", "pemex"))] ## retained: "fchApprov5", 
#
# rename to d
d <- m
rm(m,tmp)
#
rownames(d) <- paste("lg", 1:nrow(d), sep = "")
head(d)

# prepare matrix with elite and envud bridge stimuli
# reorder columns
e.n.br <- e.n.br[, c("t.order","d.cfePriv","d.pemexPriv","t.mxDemoc","t.ifeTrust","d.fchApprov","t.moreTradeGood","t.privBus","t.antiAbortion","t.antiGay","t.progConser","t.lrSelf")] # drops t.freedom t.invisibleHand
#
# fix polarity
d.br$t.abortionOK <- mapvalues(as.numeric(d.br$t.abortionOK), from = 0:4, to =  c(0,4:1))
colnames(d.br)[grep("abortion", colnames(d.br))] <- "t.abortionKO"
d.br$t.gayUnionOK <- mapvalues(as.numeric(d.br$t.gayUnionOK), from = 0:4, to =  c(0,4:1))
colnames(d.br)[grep("gay", colnames(d.br))] <- "t.gayUnionKO"
#
colnames(e.n.br)
colnames(d.br)
#
# make thermometer ranges equal in every bridge question (randomly splitting shorter-thermometer into more categories)
table(e.n.br$t.order)
table(d.br$d.orden)
tmp <- tmp1 <- d.br$d.orden
cat <- 2; rnd <- tmp2 <- runif( n = length(tmp) ) # random number will split category into "cat" categories
rnd[tmp2<=1/cat] <- 0; rnd[tmp2>1/cat] <- 1; rnd[tmp2>2/cat] <- 2 # last alters stuff only for cat==3
tmp[tmp1>0] <- tmp[tmp1>0] + rnd[tmp1>0]
d.br$d.orden <- tmp
#
table(e.n.br$t.mxDemoc)
table(d.br$t.demProg)
tmp <- tmp1 <- d.br$t.demProg
tmp <- mapvalues(as.numeric(tmp), from = 1:4, to =  c(1,3,6,9))
cat <- 2; rnd <- tmp2 <- runif( n = length(tmp) ) # random number will split category into "cat" categories
rnd[tmp2<=1/cat] <- 0; rnd[tmp2>1/cat] <- 1; rnd[tmp2>2/cat] <- 2 # last alters stuff only for cat==3
select <- which( tmp1==1 | tmp1==4 )
tmp[select] <- tmp[select] + rnd[select]
cat <- 3; rnd <- tmp2 <- runif( n = length(tmp) ) # random number will split category into "cat" categories
rnd[tmp2<=1/cat] <- 0; rnd[tmp2>1/cat] <- 1; rnd[tmp2>2/cat] <- 2 # last alters stuff only for cat==3
select <- which( tmp1==2 | tmp1==3 )
tmp[select] <- tmp[select] + rnd[select]
d.br$t.demProg <- tmp
#
table(e.n.br$t.ifeTrust)
table(d.br$t.ifeConf)
tmp <- tmp1 <- e.n.br$t.ifeTrust
cat <- 2; rnd <- tmp2 <- runif( n = length(tmp) ) # random number will split category into "cat" categories
rnd[tmp2<=1/cat] <- 0; rnd[tmp2>1/cat] <- 1; rnd[tmp2>2/cat] <- 2 # last alters stuff only for cat==3
tmp[tmp1>0] <- tmp[tmp1>0] + rnd[tmp1>0]
e.n.br$t.ifeTrust <- tmp
#
table(e.n.br$d.fchApprov)
table(d.br$t.fchApprov)
tmp <- tmp1 <- e.n.br$d.fchApprov
tmp <- mapvalues(as.numeric(tmp), from = 0:2, to =  c(0,1,4))
cat <- 2; rnd <- tmp2 <- runif( n = length(tmp) ) # random number will split category into "cat" categories
rnd[tmp2<=1/cat] <- 0; rnd[tmp2>1/cat] <- 1; rnd[tmp2>2/cat] <- 2 # last alters stuff only for cat==3
select <- which( tmp1==1 )
tmp[select] <- tmp[select] + rnd[select]
cat <- 3; rnd <- tmp2 <- runif( n = length(tmp) ) # random number will split category into "cat" categories
rnd[tmp2<=1/cat] <- 0; rnd[tmp2>1/cat] <- 1; rnd[tmp2>2/cat] <- 2 # last alters stuff only for cat==3
select <- which( tmp1==2 )
tmp[select] <- tmp[select] + rnd[select]
e.n.br$d.fchApprov <- tmp
#
table(e.n.br$t.moreTradeGood)
table(d.br$t.freeTradeOK)
tmp <- tmp1 <- e.n.br$t.moreTradeGood
cat <- 2; rnd <- tmp2 <- runif( n = length(tmp) ) # random number will split category into "cat" categories
rnd[tmp2<=1/cat] <- 0; rnd[tmp2>1/cat] <- 1; rnd[tmp2>2/cat] <- 2 # last alters stuff only for cat==3
select <- which( tmp1==3 )
tmp[select] <- tmp[select] + rnd[select]
e.n.br$t.moreTradeGood <- tmp
#
table(e.n.br$t.privBus)
table(d.br$t.freeMktOK)
tmp <- tmp1 <- d.br$t.freeMktOK
tmp <- mapvalues(as.numeric(tmp), from = 1:4, to =  c(1,3,6,9))
cat <- 2; rnd <- tmp2 <- runif( n = length(tmp) ) # random number will split category into "cat" categories
rnd[tmp2<=1/cat] <- 0; rnd[tmp2>1/cat] <- 1; rnd[tmp2>2/cat] <- 2 # last alters stuff only for cat==3
select <- which( tmp1==1 | tmp1==4 )
tmp[select] <- tmp[select] + rnd[select]
cat <- 3; rnd <- tmp2 <- runif( n = length(tmp) ) # random number will split category into "cat" categories
rnd[tmp2<=1/cat] <- 0; rnd[tmp2>1/cat] <- 1; rnd[tmp2>2/cat] <- 2 # last alters stuff only for cat==3
select <- which( tmp1==2 | tmp1==3 )
tmp[select] <- tmp[select] + rnd[select]
d.br$t.freeMktOK <- tmp
#
table(e.n.br$t.antiAbortion)
table(d.br$t.abortionKO)
tmp <- tmp1 <- d.br$t.abortionKO
tmp <- mapvalues(as.numeric(tmp), from = 1:4, to =  c(1,3,6,9))
cat <- 2; rnd <- tmp2 <- runif( n = length(tmp) ) # random number will split category into "cat" categories
rnd[tmp2<=1/cat] <- 0; rnd[tmp2>1/cat] <- 1; rnd[tmp2>2/cat] <- 2 # last alters stuff only for cat==3
select <- which( tmp1==1 | tmp1==4 )
tmp[select] <- tmp[select] + rnd[select]
cat <- 3; rnd <- tmp2 <- runif( n = length(tmp) ) # random number will split category into "cat" categories
rnd[tmp2<=1/cat] <- 0; rnd[tmp2>1/cat] <- 1; rnd[tmp2>2/cat] <- 2 # last alters stuff only for cat==3
select <- which( tmp1==2 | tmp1==3 )
tmp[select] <- tmp[select] + rnd[select]
d.br$t.abortionKO <- tmp
#
table(e.n.br$t.antiGay)
table(d.br$t.gayUnionKO)
tmp <- tmp1 <- d.br$t.gayUnionKO
tmp <- mapvalues(as.numeric(tmp), from = 1:4, to =  c(1,3,6,9))
cat <- 2; rnd <- tmp2 <- runif( n = length(tmp) ) # random number will split category into "cat" categories
rnd[tmp2<=1/cat] <- 0; rnd[tmp2>1/cat] <- 1; rnd[tmp2>2/cat] <- 2 # last alters stuff only for cat==3
select <- which( tmp1==1 | tmp1==4 )
tmp[select] <- tmp[select] + rnd[select]
cat <- 3; rnd <- tmp2 <- runif( n = length(tmp) ) # random number will split category into "cat" categories
rnd[tmp2<=1/cat] <- 0; rnd[tmp2>1/cat] <- 1; rnd[tmp2>2/cat] <- 2 # last alters stuff only for cat==3
select <- which( tmp1==2 | tmp1==3 )
tmp[select] <- tmp[select] + rnd[select]
d.br$t.gayUnionKO <- tmp
#
table(e.n.br$t.progConser)
table(d.br$t.libCon)
tmp <- tmp1 <- d.br$t.libCon
tmp <- mapvalues(as.numeric(tmp), from = 1:5, to =  c(1,3,5,7,9))
cat <- 2; rnd <- tmp2 <- runif( n = length(tmp) ) # random number will split category into "cat" categories
rnd[tmp2<=1/cat] <- 0; rnd[tmp2>1/cat] <- 1; rnd[tmp2>2/cat] <- 2 # last alters stuff only for cat==3
tmp[tmp1>0] <- tmp[tmp1>0] + rnd[tmp1>0]
d.br$t.libCon <- tmp
#
table(e.n.br$t.lrSelf)
table(d.br$t.leftRight)
tmp <- tmp1 <- d.br$t.leftRight
tmp <- mapvalues(as.numeric(tmp), from = 1:5, to =  c(1,3,5,7,9))
cat <- 2; rnd <- tmp2 <- runif( n = length(tmp) ) # random number will split category into "cat" categories
rnd[tmp2<=1/cat] <- 0; rnd[tmp2>1/cat] <- 1; rnd[tmp2>2/cat] <- 2 # last alters stuff only for cat==3
tmp[tmp1>0] <- tmp[tmp1>0] + rnd[tmp1>0]
d.br$t.leftRight <- tmp
rm(tmp, tmp1, tmp2)
#
# join e and b
dim(d.br)
dim(e.n.br)
colnames(d.br)
colnames(e.n.br)
tmp1 <- as.matrix(d.br);   rownames(tmp1) <- paste("leg", 1:nrow(tmp1), sep = "")
tmp2 <- as.matrix(e.n.br); rownames(tmp2) <- paste("vot", 1:nrow(tmp2), sep = "")
de.br <- rbind(tmp1, tmp2)
dim(de.br)
colnames(de.br) <- c("t.order","d.cfePriv","d.pemexPriv","t.demProg","t.ifeTrust","t.fchApprov","t.freeTradeOK","t.freeMktOK","t.abortionKO","t.gayUnionKO","t.libCon","t.leftRight")
head(de.br)
#
# id object
tmp1 <- d.id[, c("folio","edon","pty")];   rownames(tmp1) <- paste("leg", 1:nrow(tmp1), sep = "")
tmp1$d.mc <- 1
tmp2 <- e.id[, c("folio","edon","pty")];   rownames(tmp2) <- paste("vot", 1:nrow(tmp2), sep = "")
tmp2$d.mc <- 0
de.id <- rbind(tmp1, tmp2)
#
# verify true
nrow(de.br) == nrow(de.id)

##########################
## scale using blackbox ##
##########################
#
library(basicspace)

data <- d  ## choose data to use
id <- d.id      ## which id file
data <- as.matrix(data)
#head(data)

## # drop calderón approval question --- seems too close to party
sel <- grep("fch", colnames(data)); print(sel)
data <- data[, -sel]


results <- blackbox(data, missing = 0, verbose = TRUE, dims = 2, minscale = 7) # recover basic space
results$fits
results$stimuli


coords <- results$individuals[[2]]
# normalize coords
coords$c1 <- (coords$c1 - mean(coords$c1[!is.na(coords$c1)])) / sd(coords$c1[!is.na(coords$c1)])
coords$c2 <- (coords$c2 - mean(coords$c2[!is.na(coords$c2)])) / sd(coords$c2[!is.na(coords$c2)])

# see how coords correlate with all stimuli
tmp.cor <- data.frame(); dim.tmp <- 2 # SET DIMS HERE
for (i in 1:length(colnames(data))){
    for (dim in 1:dim.tmp){
        tmp <- data.frame(c=coords[,dim], stim=data[,i])
        tmp <- tmp[tmp$stim!=0 & is.na(tmp$c)==FALSE,]; # drop missings 
        tmp.cor[i,dim] <- cor( tmp$c, tmp$stim ) # if negative, multiply by -1
    }
}
colnames(tmp.cor) <- paste("dim", 1:dim.tmp, sep = "")
rownames(tmp.cor) <- colnames(data)
tmp.cor
rm(i,dim,dim.tmp,tmp)

# invert dims as necessary
coords$c1 <- -coords$c1
coords$c2 <- -coords$c2
tmp <- coords
coords$c1 <- tmp$c2
coords$c2 <- tmp$c1
rm(tmp)

## # rotate "angle" degrees counterclockwise
## rot <- function(x, angle=-pi/2){
##     x.trans <- x[[1]]*cos(angle)-x[[2]]*sin(angle);
##     y.trans <- x[[1]]*sin(angle)+x[[2]]*cos(angle);
##     trans.coord <- c(x.trans, y.trans);
##     return(trans.coord)
## }
## rotx <- function(x, angle=-pi/2){
##     x.trans <- x[[1]]*cos(angle)-x[[2]]*sin(angle);
##     return(x.trans)
## }
## roty <- function(x, angle=-pi/2){
##     y.trans <- x[[1]]*sin(angle)+x[[2]]*cos(angle);
##     return(y.trans)
## }
## #roty(x=c(.5,.5)) #debug
##
## # rotate 45 degrees counterclockwise
## tmp <- coords
## coords <- cbind(apply(coords, 1, function(x) rotx(x, angle = -pi/8)) , apply(coords, 1, function(x) roty(x, angle = -pi/8)))
## colnames(coords) <- colnames(tmp); coords <- as.data.frame(coords)
## rm(tmp)
## #
## # flip dim2
## coords$c2 <- -coords$c2

# plot coordinates
# create color element (for faster plot, loop too slow)
tmp <- id$pty
tmp[tmp==0] <- 8 # NAs to indep
tmp <- mapvalues(tmp, from = 1:8, to =  color.list)
id$col <- tmp; rm(tmp)
#    
gdir <- c("/home/eric/Dropbox/data/rollcall/dipMex/graphs/bridge/")
library(Cairo)
#title <- expression(paste("La responsividad ", rho, " y sesgo ", lambda, " de los distritos")) 
#title <- "Voter basic space, all stimuli"
title <- "Elite basic space, all stimuli"
file <- paste(gdir, "eliteBSallQs.", type, sep="")
#xlabel <- "against <- private offshore drilling -> favor"
#xlabel <- "against <- free market -> favor"
xlabel <- "left-right (econ+moral)"
#ylabel = "legal <- abortion -> ilegal"
ylabel = "distrust <- IFE -> trust"
type <-  "pdf" 
## Cairo(file=file,
##       type = type,
##       width = 6,
##       height = 6,
##       units = "in",
##       dpi = 72,
##       bg = "transparent")
#
plot(coords$c1, coords$c2, pch = 19, cex = 1, col = id$col,
     xlim = c(-1,1)*4, ylim = c(-1,1)*4,
     xlab = xlabel, ylab = ylabel, main = title)
#points(coords$c1[id$d.mc==1], coords$c2[id$d.mc==1], pch = 19, cex = .8, col = id$col[id$d.mc==1])
#mtext(text = "Preparado por Eric Magar con resultados oficiales del IFE", side = 1, line = 4, col = "grey", cex = .75)
#mtext(text = "Prepared by Eric Magar with official IFE returns", side = 1, line = 4, col = "grey", cex = .75)
#
## dev.off()

rm(i, gdir, file, title, type)

table(e.id$edon)

