#
# Options (select one audio driver and one midi driver)
#

# PortAudio (Working good. Linux OSS, Windows, MacOS X)
SOURCES += playerportaudio.cpp
HEADERS += playerportaudio.h
DEFINES += __PORTAUDIO__
# For unix, choose between static or dynamic linking of PortAudio. If you
# want dynamic use only the LIBS line, else use the two first lines.
# PortAudio files needs to be placed in ../lib for the static to work.
#unix:!macx:LIBS += -lportaudio
unix:!macx:SOURCES += ../lib/pa_lib.c ../lib/pa_convert.c ../lib/pa_unix_oss.c
unix:!macx:HEADERS += ../lib/portaudio.h ../lib/pa_host.h
win32:SOURCES += ../lib/pa_lib.c ../lib/dsound_wrapper.c ../lib/pa_dsound.c
win32:HEADERS += ../lib/portaudio.h ../lib/pa_host.h
win32:LIBS += dsound.lib
macx:SOURCES += ../../../libs/portaudio_v18/pa_lib.c ../../../libs/portaudio_v18/pa_mac_core.c ../../../libs/portaudio_v18/pa_convert.c
macx:HEADERS += ../../../libs/portaudio_v18/portaudio.h ../../../libs/portaudio_v18/pa_host.h
macx:LIBS += -framework CoreAudio
macx:INCLUDEPATH += ../../../libs/portaudio_v18


# OSS Midi (Working good, Linux specific)
unix:!macx:SOURCES += midiobjectoss.cpp
unix:!macx:HEADERS += midiobjectoss.h
unix:!macx:DEFINES += __OSSMIDI__

# Windows MIDI
win32:SOURCES += midiobjectwin.cpp
win32:HEADERS += midiobjectwin.h
win32:DEFINES += __WINMIDI__


# PortMidi (Not really working, Linux ALSA, Windows and MacOS X)
#SOURCES += midiobjectportmidi.cpp
#HEADERS += midiobjectportmidi.h
#DEFINES += __PORTMIDI__
#unix:LIBS += -lportmidi -lporttime
#win32:LIBS += ../lib/pm_dll.lib

# CoreMidi (Mac OS X)
macx:SOURCES += midiobjectcoremidi.cpp
macx:HEADERS += midiobjectcoremidi.h
macx:DEFINES += __COREMIDI__
macx:LIBS    += -framework CoreMIDI -framework CoreFoundation

# ALSA PCM (Not currently working, Linux specific)
#SOURCES += playeralsa.cpp
#HEADERS += playeralsa.h
#DEFINES += __ALSA__
#unix:LIBS += -lasound

# ALSA MIDI (Not currently working, Linux specific)
#SOURCES += midiobjectalsa.cpp
#HEADERS += midiobjectalsa.h
#DEFINES  += __ALSAMIDI__

#
# End of options
#

SOURCES	+= configobject.cpp fakemonitor.cpp controllogpotmeter.cpp controlobject.cpp controlnull.cpp controlpotmeter.cpp controlpushbutton.cpp controlrotary.cpp controlttrotary.cpp dlgchannel.cpp dlgplaycontrol.cpp dlgplaylist.cpp dlgmaster.cpp dlgcrossfader.cpp dlgsplit.cpp dlgpreferences.cpp dlgflanger.cpp enginebuffer.cpp engineclipping.cpp enginefilterblock.cpp enginefilteriir.cpp engineobject.cpp enginepregain.cpp enginevolume.cpp main.cpp midiobject.cpp midiobjectnull.cpp mixxx.cpp mixxxdoc.cpp mixxxview.cpp player.cpp soundsource.cpp soundsourcemp3.cpp monitor.cpp enginechannel.cpp enginemaster.cpp wknob.cpp wbulb.cpp wplaybutton.cpp wwheel.cpp wslider.cpp wpflbutton.cpp wplayposslider.cpp enginedelay.cpp engineflanger.cpp
HEADERS	+= configobject.h fakemonitor.h controllogpotmeter.h controlobject.h controlnull.h controlpotmeter.h controlpushbutton.h controlrotary.h controlttrotary.h defs.h dlgchannel.h dlgplaycontrol.h dlgplaylist.h dlgmaster.h dlgcrossfader.h dlgsplit.h dlgpreferences.h dlgflanger.h enginebuffer.h engineclipping.h enginefilterblock.h enginefilteriir.h engineobject.h enginepregain.h enginevolume.h midiobject.h midiobjectnull.h mixxx.h mixxxdoc.h mixxxview.h player.h soundsource.h soundsourcemp3.h monitor.h enginechannel.h enginemaster.h wknob.h wbulb.h wplaybutton.h wwheel.h wslider.h wpflbutton.h wplayposslider.h enginedelay.h engineflanger.h

unix {
  DEFINES += __UNIX__
  UI_DIR = .ui
  MOC_DIR = .moc
  OBJECTS_DIR = .obj
  SOURCES += soundsourceaudiofile.cpp
  HEADERS += soundsourceaudiofile.h
  LIBS += -laudiofile -lmad #/usr/local/lib/libmad.a # -lmad
#  Intel Compiler optimization flags
#  QMAKE_CXXFLAGS += -rcd -tpp6 -xiMK # icc pentium III
#  QMAKE_CXXFLAGS += -rcd -tpp7 -xiMKW # icc pentium IV 
#  QMAKE_CXXFLAGS += -prof_use #-genx # icc profiling
  CONFIG_PATH = \"/usr/share/mixxx\"
}

win32 {
  DEFINES += __WIN__
  INCLUDEPATH += ../lib .
  SOURCES += soundsourcesndfile.cpp
  HEADERS += soundsourcesndfile.h
  LIBS += ../lib/libmad.lib ../lib/libsndfile.lib
  QMAKE_CXXFLAGS += -GX
  QMAKE_LFLAGS += /NODEFAULTLIB:libcd /NODEFAULTLIB:libcmtd 
  #/NODEFAULTLIB:msvcrt.lib 
  CONFIG_PATH = \"c:\\mixxx\"
}

macx {
  DEFINES += __MACX__
  LIBS += -lz -framework Carbon -framework QuickTime
}

# gcc Profiling
QMAKE_CXXFLAGS_DEBUG += -pg
QMAKE_LFLAGS_DEBUG += -pg

DEFINES += CONFIG_PATH=$$CONFIG_PATH
FORMS	= dlgchanneldlg.ui dlgplaycontroldlg.ui dlgplaylistdlg.ui dlgmasterdlg.ui dlgcrossfaderdlg.ui dlgsplitdlg.ui dlgpreferencesdlg.ui dlgflangerdlg.ui
IMAGES	= filesave.xpm
unix:TEMPLATE         = app
win32:TEMPLATE       = vcapp
CONFIG	+= qt warn_on thread debug 
DBFILE	= mixxx.db
LANGUAGE	= C++
