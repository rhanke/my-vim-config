
set guioptions-=r
set guioptions-=m
set guioptions-=L
set guioptions-=T

if has('win32')
  if has('directx')
    set renderoptions=type:directx,gamma:1.0,contrast:0.2,level:1.0,geom:1,renmode:5,taamode:1
  endif
  set gfn=Source_Code_Pro:h10.5,CamingoCode:h11,DejaVu_Sans_Mono_for_Powerline:h11,Inconsolata:h12,Consolas:h12

  MaximizeWindow
else
  set gfn=Source_Code_Pro:h13,CamingoCode:h13,DejaVu_Sans_Mono_for_Powerline:h12,Inconsolata:h15,Menlo:h13
endif

