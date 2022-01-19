# README

将`beq`的判断提前到`ID`阶段，但未添加相应Hazard探测。

`beq`前若有有冲突的`I-type`指令，需在汇编中手动插入`nop`.

若有有冲突的`lw`, 需插入2条`nop`. 



`intr.coe`文件中含有插入必要`nop`后的fibonacci汇编程序