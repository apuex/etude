
hello:     file format elf64-x86-64


Disassembly of section .init:

0000000000400940 <_init>:
  400940:	48 83 ec 08          	sub    $0x8,%rsp
  400944:	48 8b 05 ad 16 20 00 	mov    0x2016ad(%rip),%rax        # 601ff8 <_DYNAMIC+0x1e0>
  40094b:	48 85 c0             	test   %rax,%rax
  40094e:	74 05                	je     400955 <_init+0x15>
  400950:	e8 8b 00 00 00       	callq  4009e0 <cob_stop_run@plt+0x10>
  400955:	48 83 c4 08          	add    $0x8,%rsp
  400959:	c3                   	retq   

Disassembly of section .plt:

0000000000400960 <__libc_start_main@plt-0x10>:
  400960:	ff 35 a2 16 20 00    	pushq  0x2016a2(%rip)        # 602008 <_GLOBAL_OFFSET_TABLE_+0x8>
  400966:	ff 25 a4 16 20 00    	jmpq   *0x2016a4(%rip)        # 602010 <_GLOBAL_OFFSET_TABLE_+0x10>
  40096c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000400970 <__libc_start_main@plt>:
  400970:	ff 25 a2 16 20 00    	jmpq   *0x2016a2(%rip)        # 602018 <_GLOBAL_OFFSET_TABLE_+0x18>
  400976:	68 00 00 00 00       	pushq  $0x0
  40097b:	e9 e0 ff ff ff       	jmpq   400960 <_init+0x20>

0000000000400980 <__stack_chk_fail@plt>:
  400980:	ff 25 9a 16 20 00    	jmpq   *0x20169a(%rip)        # 602020 <_GLOBAL_OFFSET_TABLE_+0x20>
  400986:	68 01 00 00 00       	pushq  $0x1
  40098b:	e9 d0 ff ff ff       	jmpq   400960 <_init+0x20>

0000000000400990 <cob_init@plt>:
  400990:	ff 25 92 16 20 00    	jmpq   *0x201692(%rip)        # 602028 <_GLOBAL_OFFSET_TABLE_+0x28>
  400996:	68 02 00 00 00       	pushq  $0x2
  40099b:	e9 c0 ff ff ff       	jmpq   400960 <_init+0x20>

00000000004009a0 <cob_check_version@plt>:
  4009a0:	ff 25 8a 16 20 00    	jmpq   *0x20168a(%rip)        # 602030 <_GLOBAL_OFFSET_TABLE_+0x30>
  4009a6:	68 03 00 00 00       	pushq  $0x3
  4009ab:	e9 b0 ff ff ff       	jmpq   400960 <_init+0x20>

00000000004009b0 <cob_display@plt>:
  4009b0:	ff 25 82 16 20 00    	jmpq   *0x201682(%rip)        # 602038 <_GLOBAL_OFFSET_TABLE_+0x38>
  4009b6:	68 04 00 00 00       	pushq  $0x4
  4009bb:	e9 a0 ff ff ff       	jmpq   400960 <_init+0x20>

00000000004009c0 <cob_fatal_error@plt>:
  4009c0:	ff 25 7a 16 20 00    	jmpq   *0x20167a(%rip)        # 602040 <_GLOBAL_OFFSET_TABLE_+0x40>
  4009c6:	68 05 00 00 00       	pushq  $0x5
  4009cb:	e9 90 ff ff ff       	jmpq   400960 <_init+0x20>

00000000004009d0 <cob_stop_run@plt>:
  4009d0:	ff 25 72 16 20 00    	jmpq   *0x201672(%rip)        # 602048 <_GLOBAL_OFFSET_TABLE_+0x48>
  4009d6:	68 06 00 00 00       	pushq  $0x6
  4009db:	e9 80 ff ff ff       	jmpq   400960 <_init+0x20>

Disassembly of section .plt.got:

00000000004009e0 <.plt.got>:
  4009e0:	ff 25 12 16 20 00    	jmpq   *0x201612(%rip)        # 601ff8 <_DYNAMIC+0x1e0>
  4009e6:	66 90                	xchg   %ax,%ax

Disassembly of section .text:

00000000004009f0 <_start>:
  4009f0:	31 ed                	xor    %ebp,%ebp
  4009f2:	49 89 d1             	mov    %rdx,%r9
  4009f5:	5e                   	pop    %rsi
  4009f6:	48 89 e2             	mov    %rsp,%rdx
  4009f9:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
  4009fd:	50                   	push   %rax
  4009fe:	54                   	push   %rsp
  4009ff:	49 c7 c0 d0 0c 40 00 	mov    $0x400cd0,%r8
  400a06:	48 c7 c1 60 0c 40 00 	mov    $0x400c60,%rcx
  400a0d:	48 c7 c7 e6 0a 40 00 	mov    $0x400ae6,%rdi
  400a14:	e8 57 ff ff ff       	callq  400970 <__libc_start_main@plt>
  400a19:	f4                   	hlt    
  400a1a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000400a20 <deregister_tm_clones>:
  400a20:	b8 d7 20 60 00       	mov    $0x6020d7,%eax
  400a25:	55                   	push   %rbp
  400a26:	48 2d d0 20 60 00    	sub    $0x6020d0,%rax
  400a2c:	48 83 f8 0e          	cmp    $0xe,%rax
  400a30:	48 89 e5             	mov    %rsp,%rbp
  400a33:	76 1b                	jbe    400a50 <deregister_tm_clones+0x30>
  400a35:	b8 00 00 00 00       	mov    $0x0,%eax
  400a3a:	48 85 c0             	test   %rax,%rax
  400a3d:	74 11                	je     400a50 <deregister_tm_clones+0x30>
  400a3f:	5d                   	pop    %rbp
  400a40:	bf d0 20 60 00       	mov    $0x6020d0,%edi
  400a45:	ff e0                	jmpq   *%rax
  400a47:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  400a4e:	00 00 
  400a50:	5d                   	pop    %rbp
  400a51:	c3                   	retq   
  400a52:	0f 1f 40 00          	nopl   0x0(%rax)
  400a56:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  400a5d:	00 00 00 

0000000000400a60 <register_tm_clones>:
  400a60:	be d0 20 60 00       	mov    $0x6020d0,%esi
  400a65:	55                   	push   %rbp
  400a66:	48 81 ee d0 20 60 00 	sub    $0x6020d0,%rsi
  400a6d:	48 c1 fe 03          	sar    $0x3,%rsi
  400a71:	48 89 e5             	mov    %rsp,%rbp
  400a74:	48 89 f0             	mov    %rsi,%rax
  400a77:	48 c1 e8 3f          	shr    $0x3f,%rax
  400a7b:	48 01 c6             	add    %rax,%rsi
  400a7e:	48 d1 fe             	sar    %rsi
  400a81:	74 15                	je     400a98 <register_tm_clones+0x38>
  400a83:	b8 00 00 00 00       	mov    $0x0,%eax
  400a88:	48 85 c0             	test   %rax,%rax
  400a8b:	74 0b                	je     400a98 <register_tm_clones+0x38>
  400a8d:	5d                   	pop    %rbp
  400a8e:	bf d0 20 60 00       	mov    $0x6020d0,%edi
  400a93:	ff e0                	jmpq   *%rax
  400a95:	0f 1f 00             	nopl   (%rax)
  400a98:	5d                   	pop    %rbp
  400a99:	c3                   	retq   
  400a9a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000400aa0 <__do_global_dtors_aux>:
  400aa0:	80 3d 6d 16 20 00 00 	cmpb   $0x0,0x20166d(%rip)        # 602114 <completed.7594>
  400aa7:	75 11                	jne    400aba <__do_global_dtors_aux+0x1a>
  400aa9:	55                   	push   %rbp
  400aaa:	48 89 e5             	mov    %rsp,%rbp
  400aad:	e8 6e ff ff ff       	callq  400a20 <deregister_tm_clones>
  400ab2:	5d                   	pop    %rbp
  400ab3:	c6 05 5a 16 20 00 01 	movb   $0x1,0x20165a(%rip)        # 602114 <completed.7594>
  400aba:	f3 c3                	repz retq 
  400abc:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000400ac0 <frame_dummy>:
  400ac0:	bf 10 1e 60 00       	mov    $0x601e10,%edi
  400ac5:	48 83 3f 00          	cmpq   $0x0,(%rdi)
  400ac9:	75 05                	jne    400ad0 <frame_dummy+0x10>
  400acb:	eb 93                	jmp    400a60 <register_tm_clones>
  400acd:	0f 1f 00             	nopl   (%rax)
  400ad0:	b8 00 00 00 00       	mov    $0x0,%eax
  400ad5:	48 85 c0             	test   %rax,%rax
  400ad8:	74 f1                	je     400acb <frame_dummy+0xb>
  400ada:	55                   	push   %rbp
  400adb:	48 89 e5             	mov    %rsp,%rbp
  400ade:	ff d0                	callq  *%rax
  400ae0:	5d                   	pop    %rbp
  400ae1:	e9 7a ff ff ff       	jmpq   400a60 <register_tm_clones>

0000000000400ae6 <main>:
  400ae6:	55                   	push   %rbp
  400ae7:	48 89 e5             	mov    %rsp,%rbp
  400aea:	48 83 ec 10          	sub    $0x10,%rsp
  400aee:	89 7d fc             	mov    %edi,-0x4(%rbp)
  400af1:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  400af5:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  400af9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  400afc:	48 89 d6             	mov    %rdx,%rsi
  400aff:	89 c7                	mov    %eax,%edi
  400b01:	e8 8a fe ff ff       	callq  400990 <cob_init@plt>
  400b06:	b8 00 00 00 00       	mov    $0x0,%eax
  400b0b:	e8 07 00 00 00       	callq  400b17 <HELLO>
  400b10:	89 c7                	mov    %eax,%edi
  400b12:	e8 b9 fe ff ff       	callq  4009d0 <cob_stop_run@plt>

0000000000400b17 <HELLO>:
  400b17:	55                   	push   %rbp
  400b18:	48 89 e5             	mov    %rsp,%rbp
  400b1b:	bf 00 00 00 00       	mov    $0x0,%edi
  400b20:	e8 02 00 00 00       	callq  400b27 <HELLO_>
  400b25:	5d                   	pop    %rbp
  400b26:	c3                   	retq   

0000000000400b27 <HELLO_>:
  400b27:	55                   	push   %rbp
  400b28:	48 89 e5             	mov    %rsp,%rbp
  400b2b:	48 81 ec 20 10 00 00 	sub    $0x1020,%rsp
  400b32:	89 bd ec ef ff ff    	mov    %edi,-0x1014(%rbp)
  400b38:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
  400b3f:	00 00 
  400b41:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  400b45:	31 c0                	xor    %eax,%eax
  400b47:	8b 85 ec ef ff ff    	mov    -0x1014(%rbp),%eax
  400b4d:	c1 e8 1f             	shr    $0x1f,%eax
  400b50:	0f b6 c0             	movzbl %al,%eax
  400b53:	48 85 c0             	test   %rax,%rax
  400b56:	74 28                	je     400b80 <HELLO_+0x59>
  400b58:	8b 05 c6 15 20 00    	mov    0x2015c6(%rip),%eax        # 602124 <initialized.7003>
  400b5e:	85 c0                	test   %eax,%eax
  400b60:	75 0a                	jne    400b6c <HELLO_+0x45>
  400b62:	b8 00 00 00 00       	mov    $0x0,%eax
  400b67:	e9 d1 00 00 00       	jmpq   400c3d <HELLO_+0x116>
  400b6c:	c7 05 ae 15 20 00 00 	movl   $0x0,0x2015ae(%rip)        # 602124 <initialized.7003>
  400b73:	00 00 00 
  400b76:	b8 00 00 00 00       	mov    $0x0,%eax
  400b7b:	e9 bd 00 00 00       	jmpq   400c3d <HELLO_+0x116>
  400b80:	48 8d 85 00 f0 ff ff 	lea    -0x1000(%rbp),%rax
  400b87:	48 89 85 f8 ef ff ff 	mov    %rax,-0x1008(%rbp)
  400b8e:	48 8b 85 f8 ef ff ff 	mov    -0x1008(%rbp),%rax
  400b95:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  400b9b:	48 8b 05 5e 15 20 00 	mov    0x20155e(%rip),%rax        # 602100 <cob_current_module>
  400ba2:	48 89 05 f7 14 20 00 	mov    %rax,0x2014f7(%rip)        # 6020a0 <module.7005>
  400ba9:	48 c7 05 4c 15 20 00 	movq   $0x6020a0,0x20154c(%rip)        # 602100 <cob_current_module>
  400bb0:	a0 20 60 00 
  400bb4:	8b 05 6a 15 20 00    	mov    0x20156a(%rip),%eax        # 602124 <initialized.7003>
  400bba:	85 c0                	test   %eax,%eax
  400bbc:	0f 94 c0             	sete   %al
  400bbf:	0f b6 c0             	movzbl %al,%eax
  400bc2:	48 85 c0             	test   %rax,%rax
  400bc5:	74 3d                	je     400c04 <HELLO_+0xdd>
  400bc7:	8b 05 13 15 20 00    	mov    0x201513(%rip),%eax        # 6020e0 <cob_initialized>
  400bcd:	85 c0                	test   %eax,%eax
  400bcf:	75 0a                	jne    400bdb <HELLO_+0xb4>
  400bd1:	bf 00 00 00 00       	mov    $0x0,%edi
  400bd6:	e8 e5 fd ff ff       	callq  4009c0 <cob_fatal_error@plt>
  400bdb:	ba 00 00 00 00       	mov    $0x0,%edx
  400be0:	be 0c 0d 40 00       	mov    $0x400d0c,%esi
  400be5:	bf 10 0d 40 00       	mov    $0x400d10,%edi
  400bea:	e8 b1 fd ff ff       	callq  4009a0 <cob_check_version@plt>
  400bef:	b8 20 21 60 00       	mov    $0x602120,%eax
  400bf4:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  400bfa:	c7 05 20 15 20 00 01 	movl   $0x1,0x201520(%rip)        # 602124 <initialized.7003>
  400c01:	00 00 00 
  400c04:	8b 05 fe 14 20 00    	mov    0x2014fe(%rip),%eax        # 602108 <cob_call_params>
  400c0a:	89 05 00 15 20 00    	mov    %eax,0x201500(%rip)        # 602110 <cob_save_call_params>
  400c10:	90                   	nop
  400c11:	b9 80 20 60 00       	mov    $0x602080,%ecx
  400c16:	ba 01 00 00 00       	mov    $0x1,%edx
  400c1b:	be 01 00 00 00       	mov    $0x1,%esi
  400c20:	bf 00 00 00 00       	mov    $0x0,%edi
  400c25:	b8 00 00 00 00       	mov    $0x0,%eax
  400c2a:	e8 81 fd ff ff       	callq  4009b0 <cob_display@plt>
  400c2f:	b8 20 21 60 00       	mov    $0x602120,%eax
  400c34:	8b 00                	mov    (%rax),%eax
  400c36:	89 c7                	mov    %eax,%edi
  400c38:	e8 93 fd ff ff       	callq  4009d0 <cob_stop_run@plt>
  400c3d:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  400c41:	64 48 33 0c 25 28 00 	xor    %fs:0x28,%rcx
  400c48:	00 00 
  400c4a:	74 05                	je     400c51 <HELLO_+0x12a>
  400c4c:	e8 2f fd ff ff       	callq  400980 <__stack_chk_fail@plt>
  400c51:	c9                   	leaveq 
  400c52:	c3                   	retq   
  400c53:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  400c5a:	00 00 00 
  400c5d:	0f 1f 00             	nopl   (%rax)

0000000000400c60 <__libc_csu_init>:
  400c60:	41 57                	push   %r15
  400c62:	41 56                	push   %r14
  400c64:	41 89 ff             	mov    %edi,%r15d
  400c67:	41 55                	push   %r13
  400c69:	41 54                	push   %r12
  400c6b:	4c 8d 25 8e 11 20 00 	lea    0x20118e(%rip),%r12        # 601e00 <__frame_dummy_init_array_entry>
  400c72:	55                   	push   %rbp
  400c73:	48 8d 2d 8e 11 20 00 	lea    0x20118e(%rip),%rbp        # 601e08 <__init_array_end>
  400c7a:	53                   	push   %rbx
  400c7b:	49 89 f6             	mov    %rsi,%r14
  400c7e:	49 89 d5             	mov    %rdx,%r13
  400c81:	4c 29 e5             	sub    %r12,%rbp
  400c84:	48 83 ec 08          	sub    $0x8,%rsp
  400c88:	48 c1 fd 03          	sar    $0x3,%rbp
  400c8c:	e8 af fc ff ff       	callq  400940 <_init>
  400c91:	48 85 ed             	test   %rbp,%rbp
  400c94:	74 20                	je     400cb6 <__libc_csu_init+0x56>
  400c96:	31 db                	xor    %ebx,%ebx
  400c98:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  400c9f:	00 
  400ca0:	4c 89 ea             	mov    %r13,%rdx
  400ca3:	4c 89 f6             	mov    %r14,%rsi
  400ca6:	44 89 ff             	mov    %r15d,%edi
  400ca9:	41 ff 14 dc          	callq  *(%r12,%rbx,8)
  400cad:	48 83 c3 01          	add    $0x1,%rbx
  400cb1:	48 39 eb             	cmp    %rbp,%rbx
  400cb4:	75 ea                	jne    400ca0 <__libc_csu_init+0x40>
  400cb6:	48 83 c4 08          	add    $0x8,%rsp
  400cba:	5b                   	pop    %rbx
  400cbb:	5d                   	pop    %rbp
  400cbc:	41 5c                	pop    %r12
  400cbe:	41 5d                	pop    %r13
  400cc0:	41 5e                	pop    %r14
  400cc2:	41 5f                	pop    %r15
  400cc4:	c3                   	retq   
  400cc5:	90                   	nop
  400cc6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  400ccd:	00 00 00 

0000000000400cd0 <__libc_csu_fini>:
  400cd0:	f3 c3                	repz retq 

Disassembly of section .fini:

0000000000400cd4 <_fini>:
  400cd4:	48 83 ec 08          	sub    $0x8,%rsp
  400cd8:	48 83 c4 08          	add    $0x8,%rsp
  400cdc:	c3                   	retq   
