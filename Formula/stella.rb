# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.70 / @SHA_*@ placeholders below with
# the real version and per-target SHA-256 sums of the prebuilt tarballs, then
# commits the result to the tap repo (macanderson/homebrew-tap) as
# Formula/stella.rb. See .github/workflows/release.yml (the `homebrew` job).
#
# Unlike packaging/homebrew/stella.rb (which builds from source with cargo),
# this installs the prebuilt binary directly — no Rust toolchain required.
class Stella < Formula
  desc "Fast, BYOK, model-agnostic terminal coding agent"
  homepage "https://github.com/macanderson/stella"
  # Explicit version is kept intentionally: brew's URL version-scan is fragile
  # for filenames containing arch tokens (x86_64/aarch64), so we pin it.
  version "0.5.70"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.70/stella-0.5.70-aarch64-apple-darwin.tar.gz"
      sha256 "9a558cc387bd7861c3e476b705b880254f2c5157bc55ed063d2b8a51741e318e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.70/stella-0.5.70-x86_64-apple-darwin.tar.gz"
      sha256 "300121da0dfde2c9007e85fc19d52a36b3db1bf4310d0615c97a054cd60f6c31"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.70/stella-0.5.70-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "26c32186e747c964059a52454be4c660245f02feab19b989fa8a50587160a277"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.70/stella-0.5.70-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5af8aad481570532fed8a618068ce94ead4c3aa26880af37b83755bb52c1d642"
    end
  end

  # Each tarball unpacks to a single stella-<version>-<target>/ directory that
  # Homebrew descends into automatically, so the binary is at the CWD root.
  def install
    bin.install "stella"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/stella --version")
  end
end
