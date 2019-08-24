cl /nologo /MT /EHsc /O2 /c src/superluminal.cpp
lib /nologo superluminal.obj lib/PerformanceAPI_MT.lib -out:lib/superluminal.lib
del superluminal.obj