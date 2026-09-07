# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.385 / @SHA_*@ placeholders below with
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
  version "0.9.385"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.385/stella-0.9.385-aarch64-apple-darwin.tar.gz"
      sha256 "ab3ba513086c92aebc1a2b8c39c48f1699a54e8aa6abd85cb6ea8ee185f64f62"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.385/stella-0.9.385-x86_64-apple-darwin.tar.gz"
      sha256 "558f87eb94cf5bac074c80fb4b92a8cbf22b4489d02023d7a10ab34e10b97713"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.385/stella-0.9.385-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "99f2d23c96ea6019953b4844132c128146b90d3f0c994e62fb77c9cc57250b7f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.385/stella-0.9.385-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5e1c715fe32c982f467f9bf4820b938868fae3bbcd85aa052c4a5960e939a407"
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
