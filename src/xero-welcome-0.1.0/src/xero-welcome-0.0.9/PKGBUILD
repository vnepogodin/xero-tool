# Maintainer: Vladislav Nepogodin <nepogodin.vlad@gmail.com>

pkgname=xerowelcome
_pkgname=xero-welcome
pkgver=0.0.7
pkgrel=1
pkgdesc='Welcome screen for XeroLinux'
arch=('x86_64')
license=(GPLv3)
url="https://github.com/xerolinux/xero-welcome"
depends=('gtk3' 'glib2')
makedepends=('meson' 'git' 'mold' 'rustup' 'clang')
source=("${pkgname}-${pkgver}.tar.gz::$url/archive/v$pkgver.tar.gz")
sha512sums=('e8756fbace9648eea16b3de429dd09c6aeeda41e127432db9019cfc9d16669d77f3cd5759d3866a8d37ccc7710bc20c68983d9524c3490d8681e9603c47da9de')
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
