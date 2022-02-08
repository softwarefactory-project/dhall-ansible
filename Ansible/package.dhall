let Builtin =
      { AddHost =
          ./Builtin/AddHost/package.dhall sha256:6f9ad520813a3e3354a4427d4bb21c97845b5d4f17c6c5a45c410fcb7b7cea28
      , Apt =
          ./Builtin/Apt/package.dhall sha256:fe8cfc66e568b7f61bdb9d2c267436218200796db2aa68016d281513e5e3f5c4
      , AptKey =
          ./Builtin/AptKey/package.dhall sha256:bbf5cf88002d3239a73b6c3ee94832aed1ed95fe8a9b2970f1df8df9c60e5c4c
      , AptRepository =
          ./Builtin/AptRepository/package.dhall sha256:7401753cf15d695ad01ba830d56aeb19f59f7bfb33738358953020f1dbba0b4d
      , Assemble =
          ./Builtin/Assemble/package.dhall sha256:d901a9f20330ca3f030b7e3efbe78b0ed3eb247358dcf843781d95e627a5e77e
      , Assert =
          ./Builtin/Assert/package.dhall sha256:cec0ddc1eccf6ecb19b748d49e92abde382d4bfd3fb00695e21f3a772dfc5b4c
      , AsyncStatus =
          ./Builtin/AsyncStatus/package.dhall sha256:7b99a91952f76a65b40b53a85a1cc6258be4ba9ea0c90d4abd2c58cb28040c0f
      , Blockinfile =
          ./Builtin/Blockinfile/package.dhall sha256:25e5d615743deceba89a467a678fa95ffb587fa18276bb6985addc4bbf6fc374
      , Command =
          ./Builtin/Command/package.dhall sha256:64736f62a51ec1c9170f4f961b3bdf0063c8eef8e0ea3bf56c1858f1391bf474
      , Copy =
          ./Builtin/Copy/package.dhall sha256:54776fe75ea1d9890f81f126b72f03590d1c39bfcda66022052720238179fbb2
      , Cron =
          ./Builtin/Cron/package.dhall sha256:c61fdfb1b0b84777152228e2c214d0c800dee28a16cdef2793f075af80694ed5
      , Debconf =
          ./Builtin/Debconf/package.dhall sha256:c63f41acae5dcbafbee803c8b856604bcf4d900fe304a0def9786998a971abe1
      , Debug =
          ./Builtin/Debug/package.dhall sha256:b06172a037d473e49c43fde56d9c06a828382f44d4a8396db44d35def2d9f2a9
      , Dnf =
          ./Builtin/Dnf/package.dhall sha256:a81da9316139c19c9aed9a4420a9803e33dbd4109aa6288bc8f690b090bd8b08
      , DpkgSelections =
          ./Builtin/DpkgSelections/package.dhall sha256:278b48a98bb47e116898e2357cec91365f06631e08624bda55096453c65aa51d
      , Expect =
          ./Builtin/Expect/package.dhall sha256:bda482b12c80e1227f1b94905ef366524450859e4894548c9335ef064fbbde7f
      , Fail =
          ./Builtin/Fail/package.dhall sha256:06600ff35d78e01932f4b01cb5a0c990b78cdcdf1aa8814928ae74d9712a8ab4
      , Fetch =
          ./Builtin/Fetch/package.dhall sha256:5569821cc5c551ece14091b1eae6219fbdf7141892765168199266d26f84bb7c
      , File =
          ./Builtin/File/package.dhall sha256:27d04efd7c112f45ada362b88453ae0a021b9df9dac89fed7e3716c43e737aba
      , Find =
          ./Builtin/Find/package.dhall sha256:5f6df27ab70911ed954feaa930c250f2d58944ef9cb4c5407a5801a926a3777d
      , GatherFacts =
          ./Builtin/GatherFacts/package.dhall sha256:dbce9b78222229edbabaafe492ccbefc52f4ed7abadefeef21f9fdca474465c7
      , GetUrl =
          ./Builtin/GetUrl/package.dhall sha256:504c1da7dfd3e08b7a975af191831274c026cc44ac03dbaf97561a306bb6adec
      , Getent =
          ./Builtin/Getent/package.dhall sha256:4b65ce0896a722b9edb5fff43042e209dc956ee3fec1de6ffaa2a27ab9e1c8d3
      , Git =
          ./Builtin/Git/package.dhall sha256:591c22d11344bab4e2522e84a5c542b3e98b83da1b6a27012ce18572cf532b97
      , Group =
          ./Builtin/Group/package.dhall sha256:d014375cbe027dcbf224550dc40aa8d0937dcab2059fd8c40ffbbf529d3bfb23
      , GroupBy =
          ./Builtin/GroupBy/package.dhall sha256:40a644d42cb33e5427efab864289fb4673709b1660234829f6018c404e13b446
      , Hostname =
          ./Builtin/Hostname/package.dhall sha256:1c94478be16244d75a34ee9811f673542ba4ec33cd11cabccbc108b226a837da
      , ImportPlaybook =
          ./Builtin/ImportPlaybook/package.dhall sha256:790808a6693e0dcb407c07fe932f8c81bacae52a2b74cbd4f177f1827c6f95fa
      , ImportRole =
          ./Builtin/ImportRole/package.dhall sha256:373f23e5c161809f18abb30117599fa87c015a4ca392c3dec5f380c8c22980b4
      , ImportTasks =
          ./Builtin/ImportTasks/package.dhall sha256:790808a6693e0dcb407c07fe932f8c81bacae52a2b74cbd4f177f1827c6f95fa
      , Include =
          ./Builtin/Include/package.dhall sha256:790808a6693e0dcb407c07fe932f8c81bacae52a2b74cbd4f177f1827c6f95fa
      , IncludeRole =
          ./Builtin/IncludeRole/package.dhall sha256:c32f540779b8dd6ffb295a1bbe8c7fde606e7811b833a738bbbc8345db0068de
      , IncludeTasks =
          ./Builtin/IncludeTasks/package.dhall sha256:2c12a60a2804c2ea814f575b173214e3421dd2cc78a8f40e444a653a83d2a100
      , IncludeVars =
          ./Builtin/IncludeVars/package.dhall sha256:f10d00d802a30cab16c9aa61f2cf880bd9362e321e50f12a6e69628fd1cc0363
      , Iptables =
          ./Builtin/Iptables/package.dhall sha256:d237077bb56cd0c7d602c176195c41c03a30210097ee50dcccf2082aa1475541
      , KnownHosts =
          ./Builtin/KnownHosts/package.dhall sha256:7737187b1bf811e7eab8cff6a8002c39649dc216349596ac859a5f641d962d75
      , Lineinfile =
          ./Builtin/Lineinfile/package.dhall sha256:a917aa5225b6c415c8b4ce0638f3448aad5ce5825d1f813042defb991525ac2a
      , Meta =
          ./Builtin/Meta/package.dhall sha256:d8b0c124798c0f1e8f2933f464356085a180134ee012a1db381f966549439ef6
      , Package =
          ./Builtin/Package/package.dhall sha256:50b269ac08124c9735b822e43072ed422349b981a923a9f475ce8a5fae3956fd
      , PackageFacts =
          ./Builtin/PackageFacts/package.dhall sha256:9509f36f97fbf7542092da95c5d210bb634a9f52f99e8a42c5a2a6b967cef9f4
      , Pause =
          ./Builtin/Pause/package.dhall sha256:6a777a9d52b4487be09b96a7dec3b94adf438d9071b2a8abbc9d04a743693fef
      , Ping =
          ./Builtin/Ping/package.dhall sha256:859987b13dddd219c0c90a4c92f441f16f039b60cab8c26c43681fbd7392264c
      , Pip =
          ./Builtin/Pip/package.dhall sha256:d4732917ea7ca4558763a3bfb799101297364345ea468465ec835b75eaf254de
      , Raw =
          ./Builtin/Raw/package.dhall sha256:1fee67eee5b2ec121a3644fae1c4baa47d36830b393353828b835e6329059550
      , Reboot =
          ./Builtin/Reboot/package.dhall sha256:90d839361884e37e364e7401e1edf85b2d6c7cdc4da503c92c813de01dffff6d
      , Replace =
          ./Builtin/Replace/package.dhall sha256:ad3ae148dff87870c5d768a521effe954fc2ad804f2b16118cb2e81e37db8741
      , RpmKey =
          ./Builtin/RpmKey/package.dhall sha256:bc68af16beb01272e4b33f3a351a2e89bbdedce6373fc9480cae9c646fa422f6
      , Script =
          ./Builtin/Script/package.dhall sha256:c6ab4f79a04fdaa23dfeee20c1f4610b5460cad924c77373cb2989269da7d6cd
      , Service =
          ./Builtin/Service/package.dhall sha256:bb6214095ca63a45e872089aa7398337991e305be832f162f1693761f800798c
      , ServiceFacts =
          ./Builtin/ServiceFacts/package.dhall sha256:81a1bf11fb9dc588941bd83400ed571298585a700a53e858456806f7ea3b8ce2
      , SetStats =
          ./Builtin/SetStats/package.dhall sha256:86c0c38155fe2e9658fb9b7ee1cc3a6b604f2c7d5677943372a5f5ecedec4ac1
      , Setup =
          ./Builtin/Setup/package.dhall sha256:da8e849e537ca723488bcae993060fc843d3048883fe439865d7b7ed74b52e1f
      , Shell =
          ./Builtin/Shell/package.dhall sha256:b445d1b32734ab4ff4f61f591f678b221b102f965ab5ddc9910bc9b7d9256700
      , Slurp =
          ./Builtin/Slurp/package.dhall sha256:1d323faff2ddd6e0d0d41e5436b1f428d6eb8f224481b0d720b1b0db414e4d9b
      , Stat =
          ./Builtin/Stat/package.dhall sha256:3c4b2c7b9ca3caca84945ea89f72b99defdc8b99d8170ecc50e69a3e07e3aeb9
      , Subversion =
          ./Builtin/Subversion/package.dhall sha256:b9d3aa0cc83af358c48f8ccdc6d065dea805526343fe0e1b6dbb858c1b9845ea
      , Systemd =
          ./Builtin/Systemd/package.dhall sha256:ca0bf6f161e80cd2cdb13db09ac7f6f49a399ad5cae49fa8d7135626cfff1c65
      , Sysvinit =
          ./Builtin/Sysvinit/package.dhall sha256:131e0dc84f01cbf5c54344d66c1a125232f14044d0c021347e70cb3949e4896d
      , Tempfile =
          ./Builtin/Tempfile/package.dhall sha256:f25e5cb6257f15c4bb836744a611b83a62cce09d2311d354e786e34ffad88b89
      , Template =
          ./Builtin/Template/package.dhall sha256:91a074e8fd49585233a59195b6977744f67074b7289b7e75faf5f6be7134ffed
      , Unarchive =
          ./Builtin/Unarchive/package.dhall sha256:11c4daea4de6919635566c2b0af757d5e849bb75210eef67aa8121b95cad48a3
      , Uri =
          ./Builtin/Uri/package.dhall sha256:4c4746b565d29f74f94575593ef999747e541057675a51e4a33761133819880c
      , User =
          ./Builtin/User/package.dhall sha256:1b2ae62d5c3e35e83ab8f5361092266f544ea274a9c4ca642485dadec7492840
      , WaitFor =
          ./Builtin/WaitFor/package.dhall sha256:587d054c28f3d5acd5d7d149bd0e02c89e85aeb741453bfca43523c48cf683e8
      , WaitForConnection =
          ./Builtin/WaitForConnection/package.dhall sha256:d38d76a492a01f398657d41cc7c5d541d0a9716bee7970fa598ee566fac9f7cb
      , Yum =
          ./Builtin/Yum/package.dhall sha256:a4148c9f0cf29cb911efc1af5c047a242d299eb2bb13528024c86837ec3de72d
      , YumRepository =
          ./Builtin/YumRepository/package.dhall sha256:ccae030c8dcf8967a820502cc2da246b220d787b616c531445e2d6cb6a23ff05
      }

in    Builtin
    ⫽ { mkBlock =
          ./mkBlock.dhall sha256:d23a02e60a7873d44f58c644b18783a575ae37a744b49166b3291c6499a7d6c1
      , BlockTask =
          ./BlockTask.dhall sha256:0080979138d2810ddf565628f5b88927ed625bf55b4b292417a97b5e3e741e0c
      , BasePlay =
          ./BasePlay/package.dhall sha256:e53d338c5dc08191b32fb18b415011ecb9c30b3db5efe3deef91331f004e7e45
      , BaseTask =
          ./BaseTask/package.dhall sha256:12501f98c344d243421ba275a7004b87fc1bd4ee45899bc978efb9aaa45d67b3
      , Builtin =
          ./Builtin/package.dhall sha256:a055823df73cdee5f7a665c73f13ebfdb55f6dc8a1da92d62298563fbfae5dbb
      , Play =
          ./Play.dhall sha256:7f972ff1a03b425cdfb34d1ef1019a8771b9e895474a35f6aab34f4638f8c73d
      , Task =
          ./Task.dhall sha256:c1543d14a8d053f37a874d1f1078b19a2839bece308e0c6936a2c6823fbb103a
      , Vars =
          ./Vars/package.dhall sha256:c1ea6158585b27d81c0f39ebdaa3c0ba4d27cec38d08f8fe5d343d1a2ba74ec4
      }
