# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.16 / @SHA_*@ placeholders below with
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
  version "0.5.16"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.16/stella-0.5.16-aarch64-apple-darwin.tar.gz"
      sha256 "c9e6f8e3fd51b5a4aa8953e5aba7e1b84100523118e829db54c4dffeeb9210c6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.16/stella-0.5.16-x86_64-apple-darwin.tar.gz"
      sha256 "a6a3fe3786660a688bdfd0061af7375b9dde33f50bf2c22287ca302351ecf82b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.16/stella-0.5.16-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "006b0a3561b1c0d61cbc2a620fc78e9b6570eeabbbaaf2a7cf54acca37352b23"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.16/stella-0.5.16-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "22911a7ec5286994155a56f66bdb18b1540c4ed2c8db96a7629a2250d1216708"
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
