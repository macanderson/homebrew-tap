# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.86 / @SHA_*@ placeholders below with
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
  version "0.9.86"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.86/stella-0.9.86-aarch64-apple-darwin.tar.gz"
      sha256 "f9ba6538d46efb333bb17ce2832436fd8fff2c7693fce0ad195f05b78e6b6145"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.86/stella-0.9.86-x86_64-apple-darwin.tar.gz"
      sha256 "02c3fa8d56991984ee96acf5772d655d4d9f85168b90ea49a6a5d094f46ee806"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.86/stella-0.9.86-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fa9282f20525660cbc5fba1363d317b7ab5dcaebad0843966244735fe4208cc2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.86/stella-0.9.86-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9f01086c25de553a87bcfee66b3b68b3421ee24536ffcf24e920ea3e11260f48"
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
