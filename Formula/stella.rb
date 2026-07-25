# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.11 / @SHA_*@ placeholders below with
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
  version "0.5.11"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.11/stella-0.5.11-aarch64-apple-darwin.tar.gz"
      sha256 "e4be044cc28898912b7dd69936ee4a2a6edbd767412c463a6af84bcb7e7ff873"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.11/stella-0.5.11-x86_64-apple-darwin.tar.gz"
      sha256 "9ba35a8da3557a508e8057db0491f1aa8e67eb7e038c6cfb8f7ef04ca0f92122"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.11/stella-0.5.11-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "46379399035e71df15fd47e6607ee6fff2266d7e93b4885d0f1e0c51e67ee9e5"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.11/stella-0.5.11-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e163b73e15bb5236d792ec863f4d3691c49d2c6d1d61f47074f5611d08a6d7be"
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
