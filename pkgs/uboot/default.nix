{ stdenv
, lib
, fetchFromGitHub
, fetchpatch
, fetchurl
, rkbin
, armTrustedFirmwareRK3399
, armTrustedFirmwareRK3588
, buildUBoot
}:
{
  ubootSW799 = buildUBoot {
    version = "v2024.04";

    src = fetchFromGitHub {
      owner = "qbisi";
      repo = "u-boot";
      rev = "374f2a14060eef133d673c186b1ef37aa4b29117";
      sha256 = "sha256-F4/zY4DSoua+rIqEMHJsw0lTzib78Iv+XnbATjnRvBQ=";
    };

    defconfig = "bozz-sw799a-rk3399_defconfig";

    ROCKCHIP_TPL = "${rkbin}/bin/rk33/rk3399_ddr_800MHz_v1.30.bin";

    extraMeta = {
      platforms = [ "aarch64-linux" ];
    };
    BL31 = "${armTrustedFirmwareRK3399}/bl31.elf";
    filesToInstall = [ "u-boot.itb" "idbloader.img" "u-boot-rockchip.bin" ];
  };

}

