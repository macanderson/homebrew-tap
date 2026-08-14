# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.47 / @SHA_*@ placeholders below with
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
  version "0.9.47"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.47/stella-0.9.47-aarch64-apple-darwin.tar.gz"
      sha256 "a5e8619a7a0b1b079c5d34829f2dd0551a30f54176d7dcdbb9e0e76376982adf"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.47/stella-0.9.47-x86_64-apple-darwin.tar.gz"
      sha256 "597f209478e2e66adf2679e16f0834f49ff9105ab0b4e5795562ee7b6c51fc18"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.47/stella-0.9.47-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3f7a59e58af2eb5e0653ed4bae226f782be134b08bba834c579f1b6af41042d8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.47/stella-0.9.47-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "dc26ea64fbdf8855bb350bf38b5ecea2d267d05f22cbda9d260f25bb2686b1eb"
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
