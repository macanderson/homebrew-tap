# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.422 / @SHA_*@ placeholders below with
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
  version "0.9.422"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.422/stella-0.9.422-aarch64-apple-darwin.tar.gz"
      sha256 "8e43af99b91c3cdaf446be814e4cafe009b655f894a166094002102e560fa6e8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.422/stella-0.9.422-x86_64-apple-darwin.tar.gz"
      sha256 "e87ba2976e286d6b561c33d020b02dc8ba56d0d1ccdde4436ee4b5203489397e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.422/stella-0.9.422-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "83ea7bf3a0e50b90361463817dccfd0204ac156619a1315407f50af0652ee526"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.422/stella-0.9.422-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2931010f9311f82bdd072fb32fbb0685827d2fafc4d9cb977cfd76d94f9b635d"
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
