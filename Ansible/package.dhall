{ AddHost =
    ./AddHost.dhall sha256:b70a149459fa533e81f072bdf78f1192d49aff48cad6e4dff74fe2617fc420a1
, Apt =
    ./Apt.dhall sha256:05ee853fff83946831043da57dcbd4e725faf05ea571e435c923d234b10072c9
, AptKey =
    ./AptKey.dhall sha256:bbf5cf88002d3239a73b6c3ee94832aed1ed95fe8a9b2970f1df8df9c60e5c4c
, AptRepository =
    ./AptRepository.dhall sha256:f1b2098348f8fdb254d755708d9d648b70881cc25061650ba303c33dbad4ae48
, Assemble =
    ./Assemble.dhall sha256:d901a9f20330ca3f030b7e3efbe78b0ed3eb247358dcf843781d95e627a5e77e
, Assert =
    ./Assert.dhall sha256:cec0ddc1eccf6ecb19b748d49e92abde382d4bfd3fb00695e21f3a772dfc5b4c
, AsyncStatus =
    ./AsyncStatus.dhall sha256:7b99a91952f76a65b40b53a85a1cc6258be4ba9ea0c90d4abd2c58cb28040c0f
, BlockTask =
    ./BlockTask.dhall sha256:c6f0b804f095df4d8fecf099d9b0a7ecc146bbf206b572337cabb0fd4a1fe452
, Blockinfile =
    ./Blockinfile.dhall sha256:25e5d615743deceba89a467a678fa95ffb587fa18276bb6985addc4bbf6fc374
, Command =
    ./Command.dhall sha256:64736f62a51ec1c9170f4f961b3bdf0063c8eef8e0ea3bf56c1858f1391bf474
, Copy =
    ./Copy.dhall sha256:54776fe75ea1d9890f81f126b72f03590d1c39bfcda66022052720238179fbb2
, Cron =
    ./Cron.dhall sha256:4762dc28ce626c1ea2daf2a6f5c850cb241711dfe59ebdd0898d44739a53eb9c
, Debconf =
    ./Debconf.dhall sha256:c63f41acae5dcbafbee803c8b856604bcf4d900fe304a0def9786998a971abe1
, Debug =
    ./Debug.dhall sha256:b06172a037d473e49c43fde56d9c06a828382f44d4a8396db44d35def2d9f2a9
, Dnf =
    ./Dnf.dhall sha256:6f4c07d1a7545440efa3e6c08b0b69effe9b2e8f23805745013be8d48bfc61bc
, DpkgSelections =
    ./DpkgSelections.dhall sha256:278b48a98bb47e116898e2357cec91365f06631e08624bda55096453c65aa51d
, Expect =
    ./Expect.dhall sha256:bda482b12c80e1227f1b94905ef366524450859e4894548c9335ef064fbbde7f
, Fail =
    ./Fail.dhall sha256:06600ff35d78e01932f4b01cb5a0c990b78cdcdf1aa8814928ae74d9712a8ab4
, Fetch =
    ./Fetch.dhall sha256:5569821cc5c551ece14091b1eae6219fbdf7141892765168199266d26f84bb7c
, File =
    ./File.dhall sha256:27d04efd7c112f45ada362b88453ae0a021b9df9dac89fed7e3716c43e737aba
, Find =
    ./Find.dhall sha256:6847bdc84d10755d617a8271157f337fd94edd0a650eaaf33c8ea5f95282c6e3
, GatherFacts =
    ./GatherFacts.dhall sha256:dbce9b78222229edbabaafe492ccbefc52f4ed7abadefeef21f9fdca474465c7
, GetUrl =
    ./GetUrl.dhall sha256:e30f4c45d8111cfcc54be8310851c70bbfe078c767b9e547f0c4d329eba170b3
, Getent =
    ./Getent.dhall sha256:4b65ce0896a722b9edb5fff43042e209dc956ee3fec1de6ffaa2a27ab9e1c8d3
, Git =
    ./Git.dhall sha256:47db6f110ed8bc9c10acd6980cddaf910532ae80bf44e76203457683be6e20d1
, Group =
    ./Group.dhall sha256:d014375cbe027dcbf224550dc40aa8d0937dcab2059fd8c40ffbbf529d3bfb23
, GroupBy =
    ./GroupBy.dhall sha256:40a644d42cb33e5427efab864289fb4673709b1660234829f6018c404e13b446
, Hostname =
    ./Hostname.dhall sha256:961d75c3d254b83d62ac6002f7e6da0bfdd44e9ea94fe3504bc6bf86ac9679c7
, ImportPlaybook =
    ./ImportPlaybook.dhall sha256:dac5a4cf021145626fb744920dd198ae7dc2e9a43de37fe748fba4f3b6164935
, ImportRole =
    ./ImportRole.dhall sha256:90415397c05bef1213f1c0398930fe437eea1b93c1a748c07a09b48d6687da20
, ImportTasks =
    ./ImportTasks.dhall sha256:dac5a4cf021145626fb744920dd198ae7dc2e9a43de37fe748fba4f3b6164935
, Include =
    ./Include.dhall sha256:dac5a4cf021145626fb744920dd198ae7dc2e9a43de37fe748fba4f3b6164935
, IncludeRole =
    ./IncludeRole.dhall sha256:78747110e2c9eaae23c80ac67eadf543d92983b44b2f3211a560a22193172536
, IncludeTasks =
    ./IncludeTasks.dhall sha256:f8e961d981aa0c78153de2ed11da3194141ee6fc9a62124e3acb66cec2693a96
, IncludeVars =
    ./IncludeVars.dhall sha256:031abb70bc1c237d26a0a6f0fc42469b8cbe5091721260780cd96742e995b11c
, Iptables =
    ./Iptables.dhall sha256:69d0a33ca0b2587c966be016e6040c383744c435e7d338bf08f2038d713a76ae
, KnownHosts =
    ./KnownHosts.dhall sha256:7737187b1bf811e7eab8cff6a8002c39649dc216349596ac859a5f641d962d75
, Lineinfile =
    ./Lineinfile.dhall sha256:b1ccf4829fad42ea1fe6d2519b1efaaed78ec7e19be3846b0482d869216671d7
, Meta =
    ./Meta.dhall sha256:3f52d4b02bce873dec0605f6b064c95de3c4e7e84d77e5ffc571efb120f830e5
, Package =
    ./Package.dhall sha256:50b269ac08124c9735b822e43072ed422349b981a923a9f475ce8a5fae3956fd
, PackageFacts =
    ./PackageFacts.dhall sha256:9509f36f97fbf7542092da95c5d210bb634a9f52f99e8a42c5a2a6b967cef9f4
, Pause =
    ./Pause.dhall sha256:6a777a9d52b4487be09b96a7dec3b94adf438d9071b2a8abbc9d04a743693fef
, Ping =
    ./Ping.dhall sha256:859987b13dddd219c0c90a4c92f441f16f039b60cab8c26c43681fbd7392264c
, Pip =
    ./Pip.dhall sha256:d4732917ea7ca4558763a3bfb799101297364345ea468465ec835b75eaf254de
, Play =
    ./Play.dhall sha256:eed3d1a06e8abee72a26e32130f76ca51c696261c2aba2cccc45842342ac1b44
, Raw =
    ./Raw.dhall sha256:1fee67eee5b2ec121a3644fae1c4baa47d36830b393353828b835e6329059550
, Reboot =
    ./Reboot.dhall sha256:cbb8c4a21dbfdce0ccdd76c7964c1196a5d289384e0694b26a941bc66d9969f9
, Replace =
    ./Replace.dhall sha256:ad3ae148dff87870c5d768a521effe954fc2ad804f2b16118cb2e81e37db8741
, RpmKey =
    ./RpmKey.dhall sha256:bc68af16beb01272e4b33f3a351a2e89bbdedce6373fc9480cae9c646fa422f6
, Script =
    ./Script.dhall sha256:c6ab4f79a04fdaa23dfeee20c1f4610b5460cad924c77373cb2989269da7d6cd
, Service =
    ./Service.dhall sha256:bb6214095ca63a45e872089aa7398337991e305be832f162f1693761f800798c
, ServiceFacts =
    ./ServiceFacts.dhall sha256:81a1bf11fb9dc588941bd83400ed571298585a700a53e858456806f7ea3b8ce2
, SetStats =
    ./SetStats.dhall sha256:86c0c38155fe2e9658fb9b7ee1cc3a6b604f2c7d5677943372a5f5ecedec4ac1
, Setup =
    ./Setup.dhall sha256:43222800adab45199e79cb9ea539aa4f30693caa183c93e59dd378bdad4c1baa
, Shell =
    ./Shell.dhall sha256:b445d1b32734ab4ff4f61f591f678b221b102f965ab5ddc9910bc9b7d9256700
, Slurp =
    ./Slurp.dhall sha256:1d323faff2ddd6e0d0d41e5436b1f428d6eb8f224481b0d720b1b0db414e4d9b
, Stat =
    ./Stat.dhall sha256:3c4b2c7b9ca3caca84945ea89f72b99defdc8b99d8170ecc50e69a3e07e3aeb9
, Subversion =
    ./Subversion.dhall sha256:851bb37c6877f88dcd82f3144a35fe169bd8d596bcfbc140d76d219f5e93d7c7
, Systemd =
    ./Systemd.dhall sha256:5f7d8a1fedca4950b50d1dceb658353d91e83c8b3eac32d1e0a1024e19ffa7bd
, Sysvinit =
    ./Sysvinit.dhall sha256:6951c1a03da9933314d29c24616a62c87000e16057d3d4e1a80e2d6572be644c
, Task =
    ./Task.dhall sha256:f21de72404b14eb82ffcb1bf66878fbb53b2d59f186d93be245547f8e8753970
, Tempfile =
    ./Tempfile.dhall sha256:f25e5cb6257f15c4bb836744a611b83a62cce09d2311d354e786e34ffad88b89
, Template =
    ./Template.dhall sha256:380a86405d5d0cda8bf27baf3f0a8850a8044fd20cb05d7acca0e67b35f34cbf
, Unarchive =
    ./Unarchive.dhall sha256:cfacc0041e97f699bb93e459129e50d17a74c58bb606fdbb8f4a012fc66402d4
, Uri =
    ./Uri.dhall sha256:1bcd5cb58999f067053dd50b0c37125cd365ae83ca871835b16320c07700520b
, User =
    ./User.dhall sha256:2733ad65a28ef47b727f7e6669b9b0058ecebc3d7d09e49d3b81c62fed28269b
, Vars =
    ./Vars.dhall sha256:465ca76cc34fb42d16e5d5632d1e56887499c8292bc710edf6b0244610fca11f
, WaitFor =
    ./WaitFor.dhall sha256:587d054c28f3d5acd5d7d149bd0e02c89e85aeb741453bfca43523c48cf683e8
, WaitForConnection =
    ./WaitForConnection.dhall sha256:d38d76a492a01f398657d41cc7c5d541d0a9716bee7970fa598ee566fac9f7cb
, Yum =
    ./Yum.dhall sha256:8044ad38c10d59f7c6dd7ac901727c61f3fcb2a341d64089d2c4d07bf0214f0e
, YumRepository =
    ./YumRepository.dhall sha256:8c924cfb57315f9fed870cddfdd6bcfdfff1740a97ec95d3dfa7ddec337450a5
, mkBlock =
    ./mkBlock.dhall sha256:d23a02e60a7873d44f58c644b18783a575ae37a744b49166b3291c6499a7d6c1
, BasePlay =
    ./BasePlay/package.dhall sha256:e53d338c5dc08191b32fb18b415011ecb9c30b3db5efe3deef91331f004e7e45
, BaseTask =
    ./BaseTask/package.dhall sha256:12501f98c344d243421ba275a7004b87fc1bd4ee45899bc978efb9aaa45d67b3
, Builtin =
    ./Builtin/package.dhall sha256:d52af28f28772362cddae179c3250ada799081361ecd81f3586477d3cbb02b24
}
