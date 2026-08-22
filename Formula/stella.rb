# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.133 / @SHA_*@ placeholders below with
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
  version "0.9.133"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.133/stella-0.9.133-aarch64-apple-darwin.tar.gz"
      sha256 "60ed2b422d45c244aa990017c73cd5eff452f76272b0912007651b68539c773a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.133/stella-0.9.133-x86_64-apple-darwin.tar.gz"
      sha256 "92c9f58c1e88cc9ee9cc774f6e6f80582fd613f08e9a2352826f5b5a7138494d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.133/stella-0.9.133-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2ab9d17f0c96d8b506286d426fa76cabb871a42bc73ce4661151e86343e60d0b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.133/stella-0.9.133-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b0e7747d029fa22ddde42d57c5b239e3e9eb36a53d321a051b23537d89125e39"
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
