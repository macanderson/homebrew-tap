# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.2 / @SHA_*@ placeholders below with
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
  version "0.9.2"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.2/stella-0.9.2-aarch64-apple-darwin.tar.gz"
      sha256 "9fbc94f65c769d73ba701259231aecb27b1556c15eb58f56745e5531e0f9bd62"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.2/stella-0.9.2-x86_64-apple-darwin.tar.gz"
      sha256 "f546035f78e66db3863d102090e0352994692ed18aa339e1467d74db6f08d81c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.2/stella-0.9.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d01f09ca25829ea87114f6f322b56f977485cb33cfd19ea1170a0d8e9dbc1674"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.2/stella-0.9.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "55eef3d3ca752788cc27b0b62b425602e74dd37a6c3496ca0164e8bb262994c2"
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
