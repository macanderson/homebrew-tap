# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.434 / @SHA_*@ placeholders below with
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
  version "0.9.434"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.434/stella-0.9.434-aarch64-apple-darwin.tar.gz"
      sha256 "70e614647a18542424e428cd7edc749ce508126d14ca64718d946aa3f3ff49fd"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.434/stella-0.9.434-x86_64-apple-darwin.tar.gz"
      sha256 "d3f871e87eaaf3f56573a9dad75c75d8cf8e79bcce4fb912f29ed3d4bd898700"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.434/stella-0.9.434-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a24e0e9d577576a8353fde34bbf4cd420ebbeb193ef2fd2c723ee33907df31e6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.434/stella-0.9.434-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6cbc532cd86c056bceb73bd6d9f4bc5623238c15f70bac527af6c11618d5c211"
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
