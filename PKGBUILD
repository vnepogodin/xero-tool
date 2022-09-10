# Maintainer: Vladislav Nepogodin <nepogodin.vlad@gmail.com>

pkgname=xerowelcome
_pkgname=xero-tool
pkgver=0.0.4
pkgrel=1
pkgdesc='Welcome screen for XeroLinux'
arch=('x86_64')
license=(GPLv3)
url="https://github.com/vnepogodin/xero-tool"
depends=('gtk3' 'glib2')
makedepends=('meson' 'git' 'mold' 'rustup' 'clang')
source=("${pkgname}-${pkgver}.tar.gz::$url/archive/v$pkgver.tar.gz")
sha512sums=('1e451b301f7ba1aefd181cd76d9ea2b8f320ea932ba79286c33b05d1794c1893ec711dac1146e2e373a8a588814d7560295bea69fe7185b4f65d54f14071cb5e')
provides=('xero-tool')
conflicts=('xero-tool')
options=(strip)

build() {
  cd "${srcdir}/${_pkgname}-${pkgver}"

  if ! rustc --version | grep nightly >/dev/null 2>&1; then
    echo "Installing nightly compiler…"
    rustup toolchain install nightly
    rustup default nightly
  fi

  _cpuCount=$(grep -c -w ^processor /proc/cpuinfo)

  export RUSTFLAGS="-Cembed-bitcode -C opt-level=3 -Ccodegen-units=1 -Clinker=clang -C link-arg=-flto -Clink-arg=-fuse-ld=/usr/bin/mold"
  meson --buildtype=release --prefix=/usr build

  meson compile -C build --jobs $_cpuCount
}

package() {
  cd "${srcdir}/${_pkgname}-${pkgver}"/build

  export RUSTFLAGS="-Cembed-bitcode -C opt-level=3 -Ccodegen-units=1 -Clinker=clang -C link-arg=-flto -Clink-arg=-fuse-ld=/usr/bin/mold"
  DESTDIR="${pkgdir}" meson install

  cp "$pkgdir/usr/share/applications/$pkgname.desktop" "$pkgdir/usr/share/applications/system-tool.desktop"

  install -Dvm644 ../$pkgname.desktop \
    "$pkgdir/etc/skel/.config/autostart/$pkgname.desktop"
}

# vim:set sw=2 sts=2 et:
