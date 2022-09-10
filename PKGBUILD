# Maintainer: Vladislav Nepogodin <nepogodin.vlad@gmail.com>

pkgname=xerowelcome
pkgver=0.0.1
pkgrel=1
pkgdesc='Welcome screen for XeroLinux'
arch=('x86_64')
license=(GPLv3)
url="https://github.com/vnepogodin/xero-tool"
depends=('gtk3' 'glib2')
makedepends=('meson' 'git' 'mold' 'rustup' 'clang')
source=("${pkgname}-${pkgver}.tar.gz::$url/archive/v$pkgver.tar.gz")
sha512sums=('465cdd045abb5270e4dcba09ddab0f735ef7a9a6bbc022759393c3faaad990e2d3f2abe3cde528281787113a4f4641d22e8bf2ed765138d1731a26c67ec081c9')
provides=('xero-tool')
conflicts=('xero-tool')
options=(strip)

build() {
  cd "${srcdir}/${pkgname}-${pkgver}"

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
  cd "${srcdir}/${pkgname}-${pkgver}"/build

  export RUSTFLAGS="-Cembed-bitcode -C opt-level=3 -Ccodegen-units=1 -Clinker=clang -C link-arg=-flto -Clink-arg=-fuse-ld=/usr/bin/mold"
  DESTDIR="${pkgdir}" meson install

  ln -srfv "$pkgdir/usr/share/applications/system-tool.desktop" "$pkgdir/usr/share/applications/$pkgname.desktop"

  install -Dvm644 ../$pkgname.desktop \
    "$pkgdir/etc/skel/.config/autostart/$pkgname.desktop"
}

# vim:set sw=2 sts=2 et:
